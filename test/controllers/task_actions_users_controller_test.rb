# require 'test_helper'
#
# class TaskActionsUsersControllerTest < ActionDispatch::IntegrationTest
#   setup do
#     @task_actions_user = task_actions_users(:chris)
#   end
#
#   test "should get index" do
#     get task_actions_users_url
#     assert_response :success
#   end
#
#   test "should get new" do
#     get new_task_actions_user_url
#     assert_response :success
#   end
#
#   test "should create task_actions_user" do
#     assert_difference('TaskActionsUser.count') do
#       post task_actions_users_url, params: { task_actions_user: { task_action_id: @task_actions_user.task_action_id, user_id: @task_actions_user.user_id } }
#     end
#
#     assert_redirected_to task_actions_user_url(TaskActionsUser.last)
#   end
#
#   test "should show task_actions_user" do
#     get task_actions_user_url(@task_actions_user)
#     assert_response :success
#   end
#
#   test "should get edit" do
#     get edit_task_actions_user_url(@task_actions_user)
#     assert_response :success
#   end
#
#   test "should update task_actions_user" do
#     patch task_actions_user_url(@task_actions_user), params: { task_actions_user: { task_action_id: @task_actions_user.task_action_id, user_id: @task_actions_user.user_id } }
#     assert_redirected_to task_actions_user_url(@task_actions_user)
#   end
#
#   test "should destroy task_actions_user" do
#     assert_difference('TaskActionsUser.count', -1) do
#       delete task_actions_user_url(@task_actions_user)
#     end
#
#     assert_redirected_to task_actions_users_url
#   end
# end
