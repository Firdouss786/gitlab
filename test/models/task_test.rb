require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  setup do
    Current.user = users(:chris)
  end

  test "closing a non-recurring task should not respawn" do
    task = tasks(:non_recurring)
    assert_equal 1, task.task_template.tasks.count
    task.completed!
    assert_equal 1, task.task_template.tasks.count
  end

  test "closing a recurring task should respawn another" do
    task = tasks(:recurring_with_completion)
    assert_equal 1, task.task_template.tasks.count
    task.completed!
    assert_equal 2, task.task_template.tasks.count
  end

  test "respawned task should be due at" do
    task = tasks(:recurring_with_completion) # Recurs every 10 days
    task.completed!
    assert_equal task.completed_at.to_date + task.task_template.repeat_interval, task.task_template.tasks.last.due_at
  end

  test "new ad-hoc task should have state active" do
    task = BuildTaskService.new({activity: activities(:open_wp), template: task_templates(:content_load), aircraft: aircrafts(:gstbc), options: {due_at: Date.today}}).call
    task.save!
    assert_equal "active", task.reload.state
  end

  test "new respawn task should have state created" do
    task = BuildTaskService.new({template: task_templates(:content_load), aircraft: aircrafts(:gstba), options: {due_at: Date.today}}).call
    assert_equal "created", task.state
  end

  test "respawn task should change state to active after accepted by user" do
    task = tasks(:recurring_without_completion)
    assert_equal "created", task.state

    TaskAction.create(completed_at: Time.now, completion_percentage: 50, logbook_text: 'text', task_id: task.id, activity_id: task.started_in_activity_id, user_ids: [users(:chris).id])
    assert_equal "active", task.reload.state
  end

  test "completed task should have state completed" do
    task = tasks(:recurring_without_completion)
    TaskAction.create(completed_at: Time.now, completion_percentage: 100, logbook_text: 'text', task_id: task.id, activity_id: task.completed_in_activity_id, user_ids: [users(:chris).id])
    assert_equal "completed", task.reload.state
  end

  test "cannot add task if workpack is in complete or error state" do
    task = tasks(:software_load_v_2_1)
    task.started_in_activity = activities(:closed_wp)
    assert task.invalid?
    refute_empty task.errors[:base]
  end

  test "cannot edit task if workpack is in complete or error state" do
    task = tasks(:software_load_v_2_1)
    task.started_in_activity = activities(:closed_wp)
    task.logbook_text = "Updated task"
    assert task.invalid?
    refute_empty task.errors[:base]
  end

  test "completion_percentage must be an integer between 0 and 100" do
    task = tasks(:software_load_v_2_1)

    0.upto(100).each do |i|
      task.completion_percentage = i
      assert task.valid?
    end

    task.completion_percentage = -1
    assert task.invalid?
    refute_empty task.errors[:completion_percentage]

    task.completion_percentage = 101
    assert task.invalid?
    refute_empty task.errors[:completion_percentage]

    task.completion_percentage = 1.1
    assert task.invalid?
    refute_empty task.errors[:completion_percentage]
  end

end
