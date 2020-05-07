require 'test_helper'

class RepairOrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @repair_order = repair_orders(:simple_repair_order)
    sign_in_as users(:chris)
  end

  test "should get index" do
    get repair_orders_url
    assert_response :success
  end

  test "should get new" do
    get new_repair_order_url
    assert_response :success
  end

  test "should create repair_order" do
    assert_difference('RepairOrder.count') do
      post repair_orders_url, params: { repair_order: { destination_stock_location_id: @repair_order.destination_stock_location_id, origin_stock_location_id: @repair_order.origin_stock_location_id, part_transaction_id: @repair_order.part_transaction_id, user_id: @repair_order.user_id } }
    end

    assert_redirected_to repair_order_url(RepairOrder.last)
  end

  test "should show repair_order" do
    get repair_order_url(@repair_order)
    assert_response :success
  end

  test "should get edit" do
    get edit_repair_order_url(@repair_order)
    assert_response :success
  end

  test "should update repair_order" do
    patch repair_order_url(@repair_order), params: { repair_order: { destination_stock_location_id: @repair_order.destination_stock_location_id, origin_stock_location_id: @repair_order.origin_stock_location_id, part_transaction_id: @repair_order.part_transaction_id, user_id: @repair_order.user_id } }
    assert_redirected_to repair_order_url(@repair_order)
  end

  test "should destroy repair_order" do
    assert_difference('RepairOrder.count', -1) do
      delete repair_order_url(@repair_order)
    end

    assert_redirected_to repair_orders_url
  end
end
