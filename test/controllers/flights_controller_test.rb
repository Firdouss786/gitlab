require 'test_helper'

class FlightsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @airline = airlines(:baw)
    sign_in_as users(:chris)
  end

  # test "should get airline flights index" do
  #   get airline_flights_url(@airline)
  #   assert_response :success
  #
  #   assert_select '.nav__leaf--active', "Flights"
  # end
  #
  # test "should render flights in air" do
  #   get airline_flights_url(@airline, state: "in_flight")
  #
  #
  #   assert_select ".flight-container", {count: 2}
  # end
  #
  # test "should default to in_air if status not set" do
  #   get airline_flights_url(@airline)
  #
  #   assert_select ".flight-container", {count: 2}
  # end
  #
  # test "should render flights on ground" do
  #   get airline_flights_url(@airline, state: "arrived")
  #
  #   assert_select ".flight-container", {count: 2}
  # end

  # test "should have a next flight" do
  #   get airline_flights_url(@airline, state: "in_flight")
  #
  #   assert_select ".schedule-container", {count: 1}
  # end


end
