# require 'test_helper'
#
# class StockItemsControllerTest < ActionDispatch::IntegrationTest
#   setup do
#     @stock_item = stock_items(:one)
#   end
#
#   test "should get index" do
#     get stock_items_url
#     assert_response :success
#   end
#
#   test "should get new" do
#     get new_stock_item_url
#     assert_response :success
#   end
#
#   test "should create stock_item" do
#     assert_difference('StockItem.count') do
#       post stock_items_url, params: { stock_item: { batch_number: stock_items(:two).batch_number, lastest_transfer_id: stock_items(:two).lastest_transfer_id, model_numbers: stock_items(:two).model_numbers, product_id: stock_items(:two).product_id, quantity: stock_items(:two).quantity, revision: stock_items(:two).revision, serial_number: stock_items(:two).serial_number, shelf_life_expiration: stock_items(:two).shelf_life_expiration, shelved_at: stock_items(:two).shelved_at, state: stock_items(:two).state, stock_location_id: @stock_item.stock_location_id, user_id: @stock_item.user_id } }
#     end
#
#     assert_redirected_to stock_item_url(StockItem.last)
#   end
#
#   test "should show stock_item" do
#     get stock_item_url(@stock_item)
#     assert_response :success
#   end
#
#   test "should get edit" do
#     get edit_stock_item_url(@stock_item)
#     assert_response :success
#   end
#
#   test "should update stock_item" do
#     patch stock_item_url(@stock_item), params: { stock_item: { batch_number: @stock_item.batch_number, lastest_transfer_id: @stock_item.lastest_transfer_id, model_numbers: @stock_item.model_numbers, product_id: @stock_item.product_id, quantity: @stock_item.quantity, revision: @stock_item.revision, serial_number: @stock_item.serial_number, shelf_life_expiration: @stock_item.shelf_life_expiration, shelved_at: @stock_item.shelved_at, state: @stock_item.state, stock_location_id: @stock_item.stock_location_id, user_id: @stock_item.user_id } }
#     assert_redirected_to stock_item_url(@stock_item)
#   end
#
#   # TODO: Test Stub
#   # test "should destroy stock_item" do
#   #   assert_difference('StockItem.count', -1) do
#   #     delete stock_item_url(@stock_item)
#   #   end
#   #
#   #   assert_redirected_to stock_items_url
#   # end
# end
