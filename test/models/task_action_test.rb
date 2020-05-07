require 'test_helper'

class TaskActionTest < ActiveSupport::TestCase

  setup do
    Current.user = users(:chris)
    @activity = activities(:open_wp)
    @task_action = task_actions(:inprogress_action)
    @task_action.users = [users(:chris)]
  end

  test "logged-in user should be authorised to activity_station and activity_aircraft to create task action" do
    Current.user = users(:maaz)
    @task_action = @task_action.dup

    assert @task_action.invalid?
    refute_empty @task_action.errors[:base]
  end

  test "logged-in user should be authorised to activity_station and activity_aircraft to update task action" do
    Current.user = users(:maaz)
    @task_action.logbook_text = 'sample text'

    assert @task_action.invalid?
    refute_empty @task_action.errors[:base]
  end

  test "cannot add task action if workpack is in complete or error state" do
    @task_action.activity = activities(:closed_wp)

    assert @task_action.invalid?
    refute_empty @task_action.errors[:base]
  end

  test "cannot edit task action if workpack is in complete or error state" do
    @task_action.activity = activities(:closed_wp)
    @task_action.completion_percentage = 60

    assert @task_action.invalid?
    refute_empty @task_action.errors[:base]
  end

  test "cannot add task action if task is already completed" do
    @task_action.task.completed!
    new_task_action = @task_action.dup

    assert new_task_action.invalid?
    refute_empty new_task_action.errors[:base]
  end

  test "cannot add task action whose completion percentage exceeds its task's 100% completion rate" do
    new_task_action = @task_action.dup
    new_task_action.completion_percentage = 80

    assert new_task_action.invalid?
    refute_empty new_task_action.errors[:completion_percentage]
  end

  test "cannot update task action whose completion percentage exceeds its task's 100% completion rate" do
    @task_action.completion_percentage = 120

    assert @task_action.invalid?
    refute_empty @task_action.errors[:completion_percentage]
  end

  test "task_actions_users must be active under activity station" do
    out_of_station_user = [users(:maaz)]
    @task_action.users = out_of_station_user

    assert @task_action.invalid?
    refute_empty @task_action.errors[:base]
  end

  test "task attributes gets updated after create" do
    new_task_action = @task_action.dup
    new_task_action.users = [users(:chris)]
    new_task_action.completion_percentage = 100 - @task_action.task.completion_percentage
    new_task_action.save

    assert_equal new_task_action.task.completion_percentage, 100
    assert_equal new_task_action.task.completed_in_activity.id, new_task_action.activity_id
    assert new_task_action.task.completed?
  end

  test "task attributes gets updated after update" do
    @task_action.completion_percentage = 100
    @task_action.save

    assert_equal @task_action.task.reload.completion_percentage, 100
    assert_equal @task_action.task.completed_in_activity.id, @task_action.activity_id
    assert @task_action.task.completed?

    @task_action.completion_percentage = 10
    @task_action.save

    assert_equal @task_action.task.completion_percentage, 10
    assert_nil @task_action.task.completed_in_activity
    assert @task_action.task.active?
  end

  test "task attributes gets updated after destroy" do
    task = @task_action.task
    @task_action.completion_percentage = 100
    @task_action.save

    assert_equal @task_action.task.completion_percentage, 100
    assert_equal @task_action.task.completed_in_activity.id, @task_action.activity_id
    assert @task_action.task.completed?

    @task_action.destroy!

    assert_equal task.completion_percentage, 0
    assert_nil task.completed_in_activity
    assert task.active?
  end

end
