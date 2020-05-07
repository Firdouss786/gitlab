require "application_system_test_case"

class DeferralsTest < ApplicationSystemTestCase

  setup do
    browser_sign_in_as users(:chris)
    @activity = activities(:open_wp)
    @fault = faults(:fault_actioned_and_raised_in_wp)
    @deferral_action = corrective_actions(:ca_other_in_wp_deferral)
  end

  test "should create new deferral" do
    visit new_activity_fault_deferral_action_path(@activity, @fault)

    select("D", from: "Defer Category").select_option
    fill_in "Document reference", with: 'sample text'
    select("INSUFFICIENT TIME", from: "deferral[defer_reason_id]").select_option
    fill_in "Logbook text", with: 'sample text'
    click_on "Submit"

    assert_text "Deferral was successfully created."
  end

  test "should edit deferral" do
    visit edit_activity_fault_deferral_action_path(@activity, @fault, @deferral_action)

    fill_in "Document reference", with: 'sample text'
    click_on "Submit"

    assert_text "Deferral was successfully updated."
  end

  test "should delete deferral" do
    visit activity_fault_deferral_action_path(@activity, @fault, @deferral_action)
    accept_confirm { click_link 'Delete' }

    assert_text "Deferral was successfully destroyed."
  end

  test "cannot destroy deferral if originating activity is in complete or error state" do
    @closed_activity = activities(:closed_wp)
    @closed_activity_deferral = corrective_actions(:ca_deferral_two)

    visit activity_fault_deferral_action_path(@closed_activity, @closed_activity_deferral, @closed_activity_deferral)
    page.accept_confirm do
      click_on "Delete", match: :first
    end

    assert_text "Deferral can only be destroyed within its originating activity and before workpack close."
  end

end
