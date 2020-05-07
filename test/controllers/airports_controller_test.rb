require 'test_helper'

class AirportsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in_as users(:chris)
    @airport = airports(:heathrow)
  end

  test "should get index" do
    get airports_path
    assert_response :success
  end

  test "should get new" do
    get new_airport_path
    assert_response :success
  end

  test "should create airport" do
    stub_request(:get, "http://flightxml.flightaware.com/json/FlightXML2/AirportInfo?airportCode=SATG").with(headers: { 'Authorization'=>'Basic' }).to_return(status: 200, body: "", headers: {})

    assert_difference('Airport.count') do
      post airports_path, params: { airport: { icao_code: 'SATG', city: @airport.city, country: @airport.country, dst: @airport.dst, iata_code: "ZZZ", name: "International Airport", timezone: @airport.timezone } }
    end

    assert_redirected_to airports_url
  end

  test "should show airport" do
    get airport_url(@airport)
    assert_response :success
  end

  test "should get edit" do
    get edit_airport_url(@airport)
    assert_response :success
  end

  test "should update airport" do
    stub_request(:get, "http://flightxml.flightaware.com/json/FlightXML2/AirportInfo?airportCode=EGLL").with(headers: { 'Authorization'=>'Basic'}).to_return(status: 200, body: "", headers: {})
    patch airport_url(@airport), params: { airport: { name: "Test name" } }
    assert_redirected_to airports_url
  end

  # TODO: Only destroy if there are no associations
  # test "should destroy airport" do
  #   assert_difference('Airport.count', -1) do
  #     delete airport_url(@airport)
  #   end
  #
  #   assert_redirected_to airports_url
  # end

end
