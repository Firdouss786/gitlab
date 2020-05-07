require "application_system_test_case"

class FaultResolutionsTest < ApplicationSystemTestCase

  setup do
    browser_sign_in_as users(:chris)
    @activity = activities(:open_wp)
    @fault = faults(:fault_actioned_and_raised_in_wp)
    @fault_ca = corrective_actions(:ca_actioned_and_raised_in_wp)
  end

  test "should show change fault status" do
    visit activity_fault_path(@activity, @fault)
    click_on ("Change Status")
    assert_text %r{#{"Fault Resolved?"}}i
  end

  test "should show fault resolution after corrective action create" do
    visit activity_fault_path(@activity, @fault)
    click_on "Add Action"

    fill_in "Job started at", with: Time.now
    fill_in "Logbook reference", with: @fault_ca.logbook_reference
    select("PARTIAL SYSTEM RESET", from: "corrective_action[maintenance_action_id]").select_option
    fill_in "Logbook text", with: @fault_ca.logbook_text
    fill_in "Document reference", with: @fault_ca.document_reference

    click_on "Create Corrective action"

    assert_text %r{#{"Fault Resolved?"}}i
    choose('fault_resolution_state_true')
    choose(option: @fault.corrective_actions.last.id.to_s)
    click_on "Save Fault resolution"
  end

  test "should show fault resolution after corrective action edit" do
    visit edit_activity_corrective_action_path(@activity, @fault_ca)
    click_on "Update Corrective action"

    assert_text %r{#{"Fault Resolved?"}}i
    choose('fault_resolution_state_false')
    click_on "Save Fault resolution"
  end

end
