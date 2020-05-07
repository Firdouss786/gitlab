require 'test_helper'

class SignOffTest < ActiveSupport::TestCase

  setup do
    Current.user = users(:chris)
    @sign_off = SignOff.new(activity: activities(:open_wp), boarded_at: Time.now - 2.days, unboarded_at: Time.now)
  end

  # test "cannot sign-off if activity is already in complete or error state" do
  #   @activity = activities(:closed_wp)
  #   @sign_off = SignOff.new(activity: @activity, boarded_at: Time.now - 2.days, unboarded_at: Time.now)
  #
  #   assert @sign_off.invalid?
  #   refute_empty @sign_off.errors[:base]
  # end
  #
  # test "logged-in user must have acceess to activity_station and activity_aircraft" do
  #   Current.user = users(:maaz)
  #   assert @sign_off.invalid?
  #   refute_empty @sign_off.errors[:closed_by]
  #   assert @sign_off.errors[:closed_by].first == "logged-in user is not authorized to close workpack under this station"
  #   assert @sign_off.errors[:closed_by].last == "logged-in user is not authorized to close workpack for this airline"
  # end
  #
  # test "unboarded_at must be after boarded_at" do
  #   @sign_off.unboarded_at = @sign_off.boarded_at
  #
  #   assert @sign_off.invalid?
  #   refute_empty @sign_off.errors[:unboarded_at]
  # end
  #
  # test "boarded_at must be before any corrective_actions of this activity" do
  #   @sign_off = SignOff.new(activity: activities(:to_be_closed), unboarded_at: Time.now)
  #   @sign_off.boarded_at = activities(:to_be_closed).corrective_actions.minimum(:job_started_at) + 1.second
  #
  #   assert @sign_off.invalid?
  #   refute_empty @sign_off.errors[:boarded_at]
  # end
  #
  # test "validate open deferral states" do
  #   boarded_at = activities(:to_be_closed).corrective_actions.minimum(:job_started_at)
  #   @sign_off = SignOff.new(activity: activities(:to_be_closed), boarded_at: boarded_at, unboarded_at: Time.now)
  #   assert @sign_off.valid?
  #
  #   @ca = corrective_actions(:ca_deferral_five)
  #   @ca.destroy
  #
  #   assert @sign_off.invalid?
  # end
  #
  # test "validate tasks states" do
  #   activity = activities(:to_be_closed)
  #   boarded_at = activity.corrective_actions.minimum(:job_started_at)
  #   @sign_off = SignOff.new(activity: activity, boarded_at: boarded_at, unboarded_at: Time.now)
  #   assert @sign_off.valid?
  #
  #   activity.tasks.create(name: "test", task_template: task_templates(:content_load), aircraft: activity.aircraft)
  #   assert @sign_off.invalid?
  # end
  #
  # test "validate logbook states" do
  #   boarded_at = activities(:to_be_closed).corrective_actions.minimum(:job_started_at)
  #   @sign_off = SignOff.new(activity: activities(:to_be_closed), boarded_at: boarded_at, unboarded_at: Time.now)
  #   assert @sign_off.valid?
  #
  #   @sign_off.activity.faults.last.active!
  #   assert @sign_off.invalid?
  # end

end
