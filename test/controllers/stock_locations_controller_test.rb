# require 'test_helper'
#
# class StockLocationsControllerTest < ActionDispatch::IntegrationTest
#   setup do
#     @stock_location = stock_locations(:one)
#   end
#
#   test "should get index" do
#     get stock_locations_url
#     assert_response :success
#   end
#
#   test "should get new" do
#     get new_stock_location_url
#     assert_response :success
#   end
#
#   test "should create stock_location" do
#     assert_difference('StockLocation.count') do
#       post stock_locations_url, params: { stock_location: { category: @stock_location.category, name: @stock_location.name, parent_id: @stock_location.parent.id, parent_type: @stock_location.parent_type } }
#     end
#
#     assert_redirected_to stock_location_url(StockLocation.last)
#   end
#
#   test "should show stock_location" do
#     get stock_location_url(@stock_location)
#     assert_response :success
#   end
#
#   test "should get edit" do
#     get edit_stock_location_url(@stock_location)
#     assert_response :success
#   end
#
#   test "should update stock_location" do
#     patch stock_location_url(@stock_location), params: { stock_location: { category: @stock_location.category, name: @stock_location.name, parent: @stock_location.parent, parent_type: @stock_location.parent_type } }
#     assert_redirected_to stock_location_url(@stock_location)
#   end
#
#   # TODO: Stub Test
#   # test "should destroy stock_location" do
#   #   assert_difference('StockLocation.count', -1) do
#   #     delete stock_location_url(@stock_location)
#   #   end
#   #
#   #   assert_redirected_to stock_locations_url
#   # end
# end
