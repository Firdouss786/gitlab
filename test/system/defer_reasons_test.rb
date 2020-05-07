require "application_system_test_case"

class DeferReasonsTest < ApplicationSystemTestCase
  setup do
    browser_sign_in_as users(:chris)
    @defer_reason = defer_reasons(:no_access)
  end

  test "visiting the index" do
    visit defer_reasons_url
    assert_selector "h1", text: "Settings"
  end

  test "creating a Defer reason" do
    visit defer_reasons_url
    click_on "New Defer Reason"

    fill_in "Description", with: 'SIA Specific: Verified content problem'
    fill_in "Name", with: 'CONTENT ISSUE'
    click_on "Create Defer reason"

    assert_text "Defer reason was successfully created"
  end

  # Note: Below tests commented as of now due to pending new implementation for Edit/Delete icons.
  # test "updating a Defer reason" do
  #   visit defer_reasons_url
  #   click_on "Edit", match: :first

  #   fill_in "Description", with: @defer_reason.description
  #   fill_in "Name", with: @defer_reason.name
  #   click_on "Update Defer reason"

  #   assert_text "Defer reason was successfully updated"
  #   click_on "Back"
  # end

  # test "destroying a Defer reason" do
  #   visit defer_reasons_url
  #   page.accept_confirm do
  #     click_on "Destroy", match: :first
  #   end

  #   assert_text "Defer reason was successfully destroyed"
  # end
end
