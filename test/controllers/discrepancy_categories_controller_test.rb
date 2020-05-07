require 'test_helper'

class DiscrepancyCategoriesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @discrepancy_category = discrepancy_categories(:avod)
    @discrepancy = discrepancies(:usb_plug)
    @new_item = "New Failure Mode Item"
    @new_category = "New Failure Mode"
    sign_in_as users(:chris)
  end

  test "should get index" do
    get discrepancy_categories_path
    assert_response :success
  end

  test "should get new" do
    get new_discrepancy_category_path
    assert_response :success
  end

  test "should create discrepancy_category" do
    assert_difference('DiscrepancyCategory.count') do
      post discrepancy_categories_path, params: { discrepancy_category: { category: @new_category } }
    end

    assert_response :redirect
    follow_redirect!
    assert_select '[data-test-id="error_explanation"]', "Failure Mode was successfully created."
  end

  test "should show discrepancy_category" do
    get discrepancy_category_path(@discrepancy_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_discrepancy_category_path(@discrepancy_category)
    assert_response :success
  end

  test "should update discrepancy_category" do
    assert_no_difference('DiscrepancyCategory.count') do
      patch discrepancy_category_path(@discrepancy_category), params: { discrepancy_category: { category: @new_category } }
    end

    assert_response :redirect
    follow_redirect!
    assert_select '[data-test-id="error_explanation"]', "Failure Mode was successfully updated."
  end

end
