require 'test_helper'

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
  end

  test "should get index" do
    sign_in_as users(:chris)
    get notifications_url
    assert_response :success
  end

  # Disabled this feature as it needs more thorough QA testing - Chris Dec 17 2019
  # test "john should see approval request from chris" do
  #   sign_in_as users(:john)
  #   get notifications_url
  #   assert_select ".pending-approvals__item", "Chris Swann requests access to British Airways"
  # end
end
