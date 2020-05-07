require 'test_helper'

class ProductAllotmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:chris)
    @product_allotment = product_allotments(:one)
    @fleet = product_allotments(:one).fleet
  end

  test "should get index" do
    get product_allotments_path(@fleet)
    assert_response :success
  end

  test "should get new" do
    get new_product_allotment_path(@fleet)
    assert_response :success
  end

  test "should create product_allotment" do
    assert_difference('ProductAllotment.count') do
      post product_allotments_path(@fleet), params: { product_allotment: { fleet_id: @fleet.id, product_id: @product_allotment.product_id, quantity: 1 } }
    end

    assert_redirected_to product_allotments_path(@fleet)
  end

  test "should show product_allotment" do
    get product_allotment_url(@fleet, @product_allotment)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_allotment_url(@fleet, @product_allotment)
    assert_response :success
  end

  test "should update product_allotment" do
    patch product_allotment_url(@fleet, @product_allotment), params: { product_allotment: { fleet_id: @fleet.id, product_id: @product_allotment.product_id, quantity: @product_allotment.quantity } }
    assert_redirected_to product_allotments_path(@fleet)
  end

  test "should destroy product_allotment" do
    assert_difference('ProductAllotment.count', -1) do
      delete product_allotment_url(@fleet, @product_allotment)
    end

    assert_redirected_to product_allotments_url
  end

end
