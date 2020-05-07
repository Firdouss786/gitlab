require 'test_helper'

class SignOffsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in_as users(:chris)
    @activity = activities(:to_be_closed)
  end

  # test "should get new" do
  #   get new_activity_sign_off_path(@activity)
  #   assert_response :success
  # end
  #
  # test "should create sign_off" do
  #   boarded_at = activities(:to_be_closed).corrective_actions.minimum(:job_started_at)
  #   post activity_sign_offs_path(@activity), params: { activity: { boarded_at: boarded_at, unboarded_at: @activity.unboarded_at } }
  #   assert_redirected_to @activity
  #
  #   @activity.reload
  #   assert @activity.complete?
  # end

end
