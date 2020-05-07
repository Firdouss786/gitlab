require 'test_helper'

class StockLocations::InboundsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in_as users(:chris)
    @stock_location = stock_locations(:lhr)
  end

  test "should get stock location inbounds index" do
    get stock_location_inbounds_path(@stock_location)
    assert_response :success
  end

  test "should get inbound transfer" do
    get stock_location_inbounds_path(@stock_location)
    assert_select 'td', transfers(:in_transit_to_lhr).id.to_s
    assert_select 'tr', 2
  end

end
