require "application_system_test_case"

class DiscrepancyCategoriesTest < ApplicationSystemTestCase

  setup do
    # @discrepancy = discrepancies(:usb_plug)
    browser_sign_in_as users(:chris)
  end

  test "click on add discrepancy shows new discrepancy category form" do
    visit discrepancy_categories_path
    click_on "New Failure Mode"
    assert_selector "form input", count: 2
    assert_selector "form label", text: %r{#{"Category"}}i
    assert_selector "form input[type=submit]", visible: true
  end

  test "add discrepancy and redirect to discrepancy_category_index page" do
    visit discrepancy_categories_path
    click_on "New Failure Mode"
    fill_in "Category", with: "Test Category"
    click_on "Create Discrepancy category"
    assert_selector '[data-test-id="error_explanation"]', text: "Failure Mode was successfully created."
  end

  test "click on edit shows edit discrepancy category form" do
    visit discrepancy_categories_path
    first('.table-body__cell a[title="Edit"]').click()
    assert_selector "form input", count: 2
    assert_selector "form label", text: %r{#{"Category"}}i
    assert_selector "form input[type=submit]", visible: true
  end

end
