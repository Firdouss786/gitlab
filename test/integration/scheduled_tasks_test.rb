require 'test_helper'

class ScheduledTasksTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:chris)
    sign_in_as @user
    @airline = airlines(:baw)
    @activity = activities(:open_wp)
  end

  test "scheduled task template respawning process" do
    assert_difference('TaskTemplate.count') do
      post airline_task_templates_path(@airline), params: { task_template: { name: "Test Template", description: "Task template to check respawning", mode: "recurring", repeat_interval: 2, config_applicabilities_attributes: [selected: 1, fleet_id: fleets(:B777).id] } }
    end

    task_template = TaskTemplate.last
    task = task_template.tasks.where(aircraft: aircrafts(:gstbc)).first

    get activity_path @activity
    assert_select "div", task_template.name
    assert task.created?

    assert put activity_task_path(@activity, task), params: { task: { started_in_activity: @activity, logbook_reference: "12345", logbook_text: "sample text" } }
    assert task.reload.active?

    assert_difference(['TaskAction.count', 'Task.count']) do
      post activity_task_actions_path(@activity, task_id: task.id), params: { task_action: { task_id: task.id, completed_at: Time.now, completion_percentage: 100, logbook_text: "sample text", user_ids: [@user.id] } }
    end

    assert task.reload.completed?

    task = Task.last
    assert task.created?
    assert task.due_at.strftime("%d %b"), (Time.now + 2.days).strftime("%d %b")
  end

end
