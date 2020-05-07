require 'test_helper'

class LogbookTest < ActiveSupport::TestCase

  setup do
    Current.user = users(:chris)
    @logbook_fault = Fault::Logbook.find(faults(:fault_opened_in_wp).id).dup
    @logbook_fault.logbook_reference = '123'
    @logbook_fault.state = nil
  end

  test "fault aircraft must match with associated activity aircraft" do
    @logbook_fault.aircraft = aircrafts(:gstba)
    assert @logbook_fault.invalid?
    refute_empty @logbook_fault.errors[:aircraft]
  end

  test "logged-in user should have access to fault aircraft on create" do
    @logbook_fault.user = users(:maaz)
    assert @logbook_fault.invalid?
    refute_empty @logbook_fault.errors[:aircraft]
  end

  test "logged-in user should have access to fault_activity_station on create" do
    @logbook_fault.user = users(:maaz)
    assert @logbook_fault.invalid?
    refute_empty @logbook_fault.errors[:user]
  end

  test "recorded_by user should have access to aircraft" do
    @logbook_fault.recorded_by = users(:maaz)
    assert @logbook_fault.invalid?
    refute_empty @logbook_fault.errors[:aircraft]
  end

  test "cannot set recorded_by user if they do not belong to the station" do
    @logbook_fault.recorded_by = users(:maaz)
    assert @logbook_fault.invalid?
    refute_empty @logbook_fault.errors[:recorded_by]
  end

  test "cannot add or edit fault if originating activity is in complete or error state except fault_resolution or deferral params" do
    @logbook_fault.activity = activities(:closed_wp)
    assert @logbook_fault.invalid?
    refute_empty @logbook_fault.errors[:base]
  end

  test "resolving_corrective_action must be under same fault and cannot already be a deferral" do
    @logbook_fault.resolving_corrective_action = corrective_actions(:system_reset)
    @logbook_fault.state = 'closed'
    assert @logbook_fault.invalid?
    refute_empty @logbook_fault.errors[:resolving_corrective_action]
  end

  test "remove resolving_corrective_action if state changes back to active or deferred" do
    @logbook_fault.resolving_corrective_action = corrective_actions(:rotable_replacement_two)
    assert @logbook_fault.save

    @logbook_fault.state = 'active'
    assert @logbook_fault.save
    assert_nil @logbook_fault.resolving_corrective_action
  end

  test "logged-in user should have access to fault_aircraft and fault_activity_station on edit" do
    @logbook_fault = Fault::Logbook.find(faults(:fault_opened_in_wp).id)
    Current.user = users(:maaz)

    assert @logbook_fault.invalid?
    refute_empty @logbook_fault.errors[:base]
  end

  test "seats impacted must be within lopa" do
    @logbook_fault.seats_impacted = "1A, 1E"
    assert @logbook_fault.valid?

    @logbook_fault.seats_impacted = "1A,1E"
    assert @logbook_fault.valid?

    @logbook_fault.seats_impacted = "1A, 999B"
    assert @logbook_fault.invalid?
    refute_empty @logbook_fault.errors[:seats_impacted]

    @logbook_fault.seats_impacted = "1A,999B"
    assert @logbook_fault.invalid?
    refute_empty @logbook_fault.errors[:seats_impacted]
  end

  test "seats impacted should update impacted_seat_count" do
    @logbook_fault.seats_impacted = "1A, 1E"
    assert @logbook_fault.save
    assert @logbook_fault.impacted_seat_count == 2

    @logbook_fault.seats_impacted = nil
    assert @logbook_fault.save
    assert_nil @logbook_fault.impacted_seat_count

    @logbook_fault.seats_impacted = ""
    assert @logbook_fault.save
    assert_nil @logbook_fault.impacted_seat_count
  end

end
