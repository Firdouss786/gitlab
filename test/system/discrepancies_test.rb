require "application_system_test_case"

class DiscrepanciesTest < ApplicationSystemTestCase

  setup do
    browser_sign_in_as users(:chris)
  end

  test "click on add item shows new discrepancy form" do
    visit discrepancy_categories_path
    find('.table-body__cell a[title="Items"]', match: :first).click()
    click_on "New Item"
    assert_selector "form input", count: 2
    assert_selector "form label", text: %r{#{"Item"}}i
    assert_selector "form input[type=submit]", visible: true
  end

  test "add discrepancy and redirect to discrepancy_index page" do
    visit discrepancy_categories_path
    find('.table-body__cell a[title="Items"]', match: :first).click()
    click_on "New Item"
    fill_in "Item", with: "Test Item"
    click_on "Create Discrepancy"
    assert_selector '[data-test-id="error_explanation"]', text: "Discrepancy was successfully created."
  end

  test "click on edit shows edit discrepancy form" do
    visit discrepancy_categories_path
    find('.table-body__cell a[title="Items"]', match: :first).click()
    first('.table-body__cell a[title="Edit"]').click()
    assert_selector "form input", count: 2
    assert_selector "form label", text: %r{#{"Item"}}i
    assert_selector "form input[type=submit]", visible: true
  end

end
