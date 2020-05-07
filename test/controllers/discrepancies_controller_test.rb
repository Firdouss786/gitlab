require 'test_helper'

class DiscrepanciesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @discrepancy_category = discrepancy_categories(:avod)
    @discrepancy = discrepancies(:usb_plug)
    @new_item = "New Failure Mode Item"
    @new_category = "New Failure Mode"
    sign_in_as users(:chris)
  end

  test "should get new" do
    get new_discrepancy_category_discrepancy_path(@discrepancy_category)
    assert_response :success
  end

  test "should create discrepancy" do
    assert_difference('Discrepancy.count') do
      post discrepancy_category_discrepancies_path(@discrepancy_category), params: { discrepancy: { discrepancy_category_id: @discrepancy_category.id, name: @discrepancy.name } }
    end

    assert_response :redirect
    follow_redirect!
    assert_select '[data-test-id="error_explanation"]', "Discrepancy was successfully created."
  end

  test "should not create discrepancy with orphaned category" do
    assert_no_difference('Discrepancy.count') do
      post discrepancy_category_discrepancies_path(@discrepancy_category), params: { discrepancy: { discrepancy_category_id: @discrepancy_category.id, name: nil } }
    end

    assert_select "[data-test-id='error_explanation']", text: "Name can't be blank"
  end

  test "should show discrepancy" do
    get discrepancy_category_discrepancy_path(@discrepancy_category, @discrepancy_category.discrepancies.first)
    assert_response :success
  end

  test "should get edit" do
    get edit_discrepancy_category_discrepancy_path(@discrepancy_category, @discrepancy_category.discrepancies.first)
    assert_response :success
  end

  test "should update discrepancy" do
    assert_no_difference('Discrepancy.count') do
      patch discrepancy_category_discrepancy_path(@discrepancy_category, @discrepancy_category.discrepancies.first), params: { discrepancy: { name: @new_item } }
    end

    assert_response :redirect
    follow_redirect!
    assert_select '[data-test-id="error_explanation"]', "Discrepancy was successfully updated."
  end

  test "should disable discrepancy" do
    assert_no_difference('Discrepancy.count') do
      patch discrepancy_category_discrepancy_path(@discrepancy.discrepancy_category, @discrepancy), params: { discrepancy: { disable: 'true' } }
      assert @discrepancy.published?
      @discrepancy.archive_by users(:chris)
      assert @discrepancy.archived?
    end

    assert_response :redirect
    follow_redirect!
    assert_select '[data-test-id="error_explanation"]', "Discrepancy was successfully updated."
  end

end
