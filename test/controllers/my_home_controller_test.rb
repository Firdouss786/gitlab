require 'test_helper'

class MyHomeControllerTest < ActionDispatch::IntegrationTest
  test "I should be redirected to my home station" do
    sign_in_as users(:chris)
    follow_redirect!
    follow_redirect!
    assert_select ".breadcrumb__leaf", text: "Workload"
  end

  test "User with no default station should be redirected to docks index" do
    sign_in_as users(:john)
    follow_redirect!
    assert_redirected_to docks_path
  end
end
