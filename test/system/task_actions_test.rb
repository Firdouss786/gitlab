require "application_system_test_case"

class TaskActionsTest < ApplicationSystemTestCase

  setup do
    browser_sign_in_as users(:chris)
    @activity = activities(:open_wp)
    @task = tasks(:transit_check)
  end

  test "creating task action under activity" do
    visit activity_task_path(@activity, @task)
    click_on("Add Action")

    select("Chris Swann", from: "task_action[user_ids][]").select_option
    fill_in "Completion Percentage (%)", with: 10
    fill_in "Action Taken", with: 'New task action created'
    click_button "Create Task action"

    find(:css, 'a[href="' + "#{activity_task_action_path(@activity, @task.task_actions.last)}" + '"]').click
    assert_text "New task action created"
  end

  test "editing task action under activity" do
    visit activity_task_path(@activity, @task)
    find(:css, 'a[href="' + "#{activity_task_action_path(@activity, @task.task_actions.first)}" + '"]').click

    find(:css, 'a[href="' + "#{edit_activity_task_action_path(@activity, @task.task_actions.first)}" + '"]').click

    select("Chris Swann", from: "task_action[user_ids][]").select_option
    click_button "Update Task action"

    find(:css, 'a[href="' + "#{activity_task_action_path(@activity, @task.task_actions.first)}" + '"]').click
    assert_text "Chris Swann"
  end

end
