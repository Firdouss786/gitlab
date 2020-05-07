require 'test_helper'

class TaskActionsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in_as users(:chris)
    @activity = activities(:open_wp)
    @task = tasks(:transit_check)
    @task_action = task_actions(:task_actioned)
  end

  test "new" do
    get new_activity_task_action_path(@activity, task_id: @task.id)
    assert_response :success
  end

  test "create" do
    assert_difference('TaskAction.count') do
      post activity_task_actions_path(@activity, task_id: @task.id), params: { task_action: { task_id: @task.id, completed_at: Time.now, completion_percentage: 5, logbook_text: @task_action.logbook_text, user_ids: [@task_action.user_id] } }
    end

    assert_redirected_to [@activity, @task]
    follow_redirect!

    assert_select "a[href=?]", activity_task_action_path(@activity, TaskAction.last), { count: 1 }
  end

  test "edit" do
    get edit_activity_task_action_path(@activity, @task_action)
    assert_response :success
  end

  test "update" do
    @task_action = task_actions(:inprogress_action)
    assert_no_difference('TaskAction.count') do
      patch activity_task_action_path(@activity, @task_action), params: { task_action: { logbook_text: 'sample text', user_ids: [@task_action.user_id] } }
    end

    assert_redirected_to [@activity, @task_action.task]
    follow_redirect!

    assert_select "div", "sample text"
  end

  test "delete" do
    @task_action = task_actions(:inprogress_action)
    assert_difference('TaskAction.count', -1) do
      delete activity_task_action_path(@activity, @task_action)
    end
  end

  test "task_action should update task completion percentage" do
    percentage_before = @task.completion_percentage

    assert_difference('TaskAction.count') do
      post activity_task_actions_path(@activity, task_id: @task.id), params: { task_action: { task_id: @task.id, completed_at: Time.now, completion_percentage: 5, logbook_text: @task_action.logbook_text, user_ids: [@task_action.user_id] } }
    end

    assert_redirected_to [@activity, @task]
    assert_equal @task.reload.completion_percentage, percentage_before + 5
  end

  test "should not update task_action outside originating activity" do
    @task_action = task_actions(:inprogress_action_two)
    assert_no_difference('TaskAction.count') do
      patch activity_task_action_path(activities(:to_be_closed), @task_action), params: { task_action: { logbook_text: 'sample text', user_ids: [users(:chris)] } }
    end

    assert_select '[data-test-id="error_explanation"]', "cannot edit task action outside its originating activity"
  end

  test "should update task users under activity" do
    @task_action = task_actions(:inprogress_action)
    patch activity_task_action_path(@activity, @task_action), params: { task_action: { logbook_text: 'sample text', user_ids: [users(:chris).id, users(:albert).id] } }

    assert_redirected_to [@activity, @task_action.task]

    assert_equal [users(:chris).id, users(:albert).id], @task_action.users.ids
  end

  test "should not delete task_action outside originating activity" do
    @task_action = task_actions(:inprogress_action_two)
    assert_no_difference('TaskAction.count') do
      delete activity_task_action_path(@activity, @task_action)
    end

    assert_equal flash.notice, "Task Action can only be destroyed within its originating activity and before workpack close."
  end

  test "should not create task_action if completion percentage greater than 100 percentage" do
    assert_no_difference('TaskAction.count') do
      post activity_task_actions_path(@activity, task_id: @task.id), params: { task_action: { task_id: @task.id, completed_at: Time.now, completion_percentage: 110, logbook_text: @task_action.logbook_text, user_ids: [@task_action.user_id] } }
    end
    assert_select '[data-test-id="error_explanation"]', "Completion percentage must be less than or equal to 100"
  end

end
