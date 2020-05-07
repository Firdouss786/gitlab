require 'test_helper'

# These tests are concerned only with tasks within an activity (AKA workpack)
class TasksControllerTest < ActionDispatch::IntegrationTest

  setup do
    @airline = airlines(:baw)
    @activity = activities(:open_wp)
    @task = tasks(:software_load_v_2_1)
    sign_in_as users(:chris)
  end

  test "index" do
    # Index test covered by ActivityController
  end

  test "show" do
    get activity_task_url(@activity, @task)
    assert_response :success
  end

  test "new" do
    get new_activity_task_url(@activity)
    assert_response :success
  end

  test "edit" do
    get edit_activity_task_path(@activity, @task)
    assert_response :success
  end

  test "create" do
    assert_difference('Task.count') do
      post activity_tasks_url(@activity), params: { task: { started_at: @task.started_at, task_template_id: task_templates(:recurring_level_2).id, logbook_reference:"Software Upload", logbook_text: "Software Upload Required" } }
    end

    assert_redirected_to [@activity, Task.last]
    follow_redirect!

    assert_select '[data-test-id="task-activity"]', @activity.id.to_s
  end

  test "update" do
    patch activity_task_path(@activity, @task), params: { task: { logbook_text: "123" } }

    assert_redirected_to [@activity, @task]
    follow_redirect!

    assert_select '[data-test-id="task-logbook-text"]', "123"
  end

  test "destroy" do
    assert_difference('Task.count', -1) do
      delete activity_task_path(@activity, tasks(:transit_check_no_actions))
    end

    assert_redirected_to @activity
  end

  # Constraints

  test "can't edit task from a previous workpack" do
    @task = tasks(:level_three_outside)
    patch activity_task_path(@activity, @task), params: { task: {logbook_reference: @task.logbook_reference, logbook_text: @task.logbook_text, started_at: @task.started_at, task_template_id: @task.task_template.id } }

    assert_select "[data-test-id='error_explanation']", "cannot edit/delete task unless created within this activity."
  end

  test "can't delete task from a previous workpack" do
    @task = tasks(:level_three_outside)

    assert_no_difference('Task.count') do
      delete activity_task_path(@activity, @task)
    end

    assert_redirected_to [@activity, @task]
    follow_redirect!

    assert_select '[data-test-id="error_explanation"]', "Operation unsuccessful. Cannot delete task if task actions are present and outside its originating activity or current activity is complete/error."
  end

  test "can't delete task with actions" do
    @task = tasks(:completed)

    assert_no_difference('Task.count') do
      delete activity_task_path(@task.started_in_activity, @task)
    end

    assert_redirected_to [@task.started_in_activity, @task]
    follow_redirect!

    assert_select '[data-test-id="error_explanation"]', "Operation unsuccessful. Cannot delete task if task actions are present and outside its originating activity or current activity is complete/error."
  end

end
