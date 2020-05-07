require "application_system_test_case"

class FlightsTest < ApplicationSystemTestCase
  setup do
    @user = users(:chris)
    @airline = airlines(:baw)
    browser_sign_in_as @user
  end

  test "should get in-flight or arrived flight details on selecting their related radio button" do
    visit airline_flights_path(@airline, status: "in_air")

    choose("Arrived")
    assert page.has_checked_field?("state_arrived")
    assert URI.parse(current_url).request_uri == airline_flights_path(@airline, state: "arrived")
    assert_selector "div.flight-container dl.aircraft dd.aircraft_number", text: aircrafts(:gstbc).tail

    choose("In Flight")
    assert page.has_checked_field?("state_in_flight")
    assert URI.parse(current_url).request_uri == airline_flights_path(@airline, state: "in_flight")
    assert_selector "div.flight-container dl.aircraft dd.aircraft_number", text: aircrafts(:gstba).tail
  end

end
