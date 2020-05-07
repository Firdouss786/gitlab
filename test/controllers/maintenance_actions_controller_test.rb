require 'test_helper'

class MaintenanceActionsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in_as users(:chris)
    @maintenance_action = maintenance_actions(:reconnect)
  end

  test "should get index" do
    get maintenance_actions_url
    assert_response :success
  end

  test "should get new" do
    get new_maintenance_action_url
    assert_response :success
  end

  test "should create maintenance_action" do
    assert_difference('MaintenanceAction.count') do
      post maintenance_actions_url, params: { maintenance_action: { name: 'Clear cache' } }
    end

    assert_redirected_to maintenance_actions_url
  end

  test "should show maintenance_action" do
    get maintenance_action_url(@maintenance_action)
    assert_response :success
  end

  test "should get edit" do
    get edit_maintenance_action_url(@maintenance_action)
    assert_response :success
  end

  test "should update maintenance_action" do
    patch maintenance_action_url(@maintenance_action), params: { maintenance_action: { description: 'Change screen' } }
    assert_redirected_to maintenance_actions_url
  end

  # test "should destroy maintenance_action" do
  #   assert_difference('MaintenanceAction.count', -1) do
  #     delete maintenance_action_url(@maintenance_action)
  #   end
  #
  #   assert_redirected_to maintenance_actions_url
  # end

end
