require 'test_helper'

class DocksControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:chris)
    sign_in_as @user
  end

  test "should show dock" do
    get docks_path
    assert_response :success
  end

  test "should show dock with default airline and station links" do
    assert_equal @user.default_airline, airlines(:baw)
    assert_equal @user.home_station, stations(:lhr)

    get docks_path
    assert_response :success

    assert_select '#dock a[href=?]', airline_flights_path(@user.default_airline), text: "My Airline"
    assert_select '#dock a[href=?]', station_activities_path(@user.home_station), text: "My Station"
  end

  test "should not show airline and station if nothing assigned" do
    @user = users(:kathrine)
    sign_in_as @user
    
    assert_nil @user.default_airline
    assert_nil @user.home_station

    get docks_path
    assert_response :success

    assert_select "#dock a", text: "My Airline", count: 0
    assert_select "#dock a", text: "My Station", count: 0
  end

end
