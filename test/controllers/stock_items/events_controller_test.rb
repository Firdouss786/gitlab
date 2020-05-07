require 'test_helper'

class StockItems::EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:chris)

    @stock_item = stock_items(:consumable_with_no_history)
  end

  test "should get index" do
    get stock_item_events_url(@stock_item)
    assert_response :success
  end

  # TODO: mark event as error
  # test "should destroy stock_items_event" do
  #   assert_difference('StockItems::Event.count', -1) do
  #     delete stock_items_event_url(@stock_items_event)
  #   end
  #
  #   assert_redirected_to stock_items_events_url
  # end
end
