require 'test_helper'

class StockLocations::ProductsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in_as users(:chris)
    @stock_location = stock_locations(:lhr)
    @stock_items = stock_items(:consumable)
    @product = products(:single_usb)
  end

  # test "should get stock location products index" do
  #   get stock_location_products_path(@stock_location)
  #   assert_response :success
  # end
  #
  # test "correct quantity of each state" do
  #   get stock_location_products_path(@stock_location)
  #   assert_select 'table' do
  #     assert_select 'tr:nth-child(2)' do
  #       assert_select 'td:nth-child(1)', @stock_items.category.upcase
  #       assert_select 'td:nth-child(2)', @product.name
  #       assert_select 'td:nth-child(3)', @product.part_number
  #       assert_select 'td:nth-child(4)', '0'
  #       assert_select 'td:nth-child(5)', '0'
  #       assert_select 'td:nth-child(6)', '2'
  #       assert_select 'td:nth-child(7)', '0'
  #       assert_select 'td:nth-child(8)', '0'
  #       assert_select 'td:nth-child(9)', '0'
  #       assert_select 'td:nth-child(10)', '0'
  #       assert_select 'td:nth-child(11)', '0'
  #       assert_select 'td:nth-child(12)', '2'
  #     end
  #   end
  # end


end
