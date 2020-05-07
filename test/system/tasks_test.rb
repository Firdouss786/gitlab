require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase

  setup do
    browser_sign_in_as users(:chris)
    @activity = activities(:open_wp)

    @add_task = "Add Task"
    @edit_selector = '[data-test-id="edit"]'
    @task_selector = '[data-test-id="task"]'
  end

  test "creating task under activity" do
    visit activity_path(@activity)
    click_on @add_task

    select("May 18 Content Load", from: "task[task_template_id]").select_option
    fill_in "Logbook reference", with: '12345'
    fill_in "Logbook text", with: 'Description'
    click_button "Create Task"

    assert_text "12345"
    assert_text "Description"
    assert_text @activity.id
  end

  test "adding a respawn task to workpack" do
    @task = tasks(:level_three)
    visit activity_path(@activity)

    find(@task_selector, text: 'Level 3').click

    fill_in "Logbook reference", with: '12345'
    fill_in "Logbook text", with: 'Description'
    click_button "Add to workpack"

    assert_text "12345"
    assert_text "Description"
    assert_text @activity.id
  end

  test "editing task under activity" do
    visit activity_path(@activity)
    page.first(@task_selector, text: 'Transit Check').click

    find(@edit_selector).click
    fill_in "Logbook reference", with: '12345'
    click_on "Update Task"

    assert_text "12345"
    assert_text @activity.id
  end

  # test "deleting task under activity" do
  #   visit activity_path(@activity)
  #
  #   click_on @add_task
  #   select("Level 1", from: "task[task_template_id]").select_option
  #   fill_in "Logbook reference", with: 'Task to delete'
  #   fill_in "Logbook text", with: 'Task to delete'
  #   click_button "Create Task"
  #
  #   find(@task_selector, text: 'Task to delete').click
  #   page.accept_confirm do
  #     click_on "Delete", match: :first
  #   end
  #   assert_text "Task was successfully destroyed."
  # end

end
