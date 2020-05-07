require 'test_helper'

class CorrectiveActionTest < ActiveSupport::TestCase

  setup do
    Current.user = users(:chris)
    @closed_activity = activities(:closed_wp)
    @ca = corrective_actions(:ca_actioned_and_raised_in_wp)
  end

  test "corrective action start date-time should be present" do
    @ca.job_started_at = nil
    assert_not @ca.valid?, 'corrective action saved without job_started_at'
    refute_empty @ca.errors[:job_started_at], 'no validation error for job_started_at present'
  end

  test "corrective action start date-time should be same or after activity start" do
    @ca.job_started_at = @ca.activity.boarded_at - 1.second
    assert_not @ca.valid?, 'corrective action saved before activity start time'
    refute_empty @ca.errors[:job_started_at], 'no validation error for job_started_at present'

    @ca.job_started_at = @ca.activity.boarded_at
    assert @ca.valid?, 'corrective action not saving with exact start time of activity'
    assert_empty @ca.errors[:job_started_at], 'validation error for job_started_at present'

    @ca.job_started_at = @ca.activity.boarded_at + 1.second
    assert @ca.valid?, 'corrective action not saving with start time after activity'
    assert_empty @ca.errors[:job_started_at], 'validation error for job_started_at present'
  end

  test "corrective action must validate replacement if consumable is selected" do
    @ca.maintenance_action = maintenance_actions(:replaced_consumable)
    @replacement_consumable = Replacement.new(installed_product: products(:single_usb))
    @ca.replacement = @replacement_consumable

    assert_not @ca.valid?, 'corrective action not validating replacement'
  end

  test "corrective action must validate replacement if rotable is selected" do
    @ca.maintenance_action = maintenance_actions(:replaced_lru)
    @replacement_rotable = Replacement.new(installed_product: products(:single_usb))
    @ca.replacement = @replacement_rotable

    assert_not @ca.valid?, 'corrective action not validating replacement'
  end

  test "cannot add corrective action if activity is in complete or error state" do
    @ca.activity = @closed_activity
    assert @ca.invalid?
    refute_empty @ca.errors[:base]
  end

  test "cannot edit corrective action if activity is in complete or error state" do
    @ca_with_closed_activity = corrective_actions(:ca_raised_in_activity)
    @ca_with_closed_activity.logbook_reference = '123'
    assert @ca_with_closed_activity.invalid?
    refute_empty @ca_with_closed_activity.errors[:base]
  end

  test "cannot add corrective action if fault is in closed or deferral_closed state" do
    @ca.fault.update(state: 'closed')
    new_ca = @ca.dup
    assert new_ca.invalid?
    refute_empty new_ca.errors[:base]
  end

  test "aircraft for activity and fault must be same" do
    @ca.fault.aircraft = aircrafts(:gstbb)
    assert @ca.invalid?
    refute_empty @ca.errors[:base]
  end

  test "destroying ca should revert fault state to active if it was in closed state and resolving_corrective_action was same as the deleted one" do
    @ca.fault.update(state: 'closed', resolving_corrective_action: @ca)
    @ca.destroy
    assert @ca.fault.active?
    assert_nil @ca.fault.resolving_corrective_action
  end

  test "logged-in user must have access to activity_station and activity_aircraft on edit" do
    Current.user = users(:maaz)
    @ca.logbook_text = "555"
    assert @ca.invalid?
    refute_empty @ca.errors[:base]
  end

end
