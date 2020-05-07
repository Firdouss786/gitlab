require 'test_helper'

class AirlinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @airline = airlines(:baw)
    @user = users(:chris)
    sign_in_as @user
  end

  test "should get index" do
    get airlines_url
    assert_response :success
  end

  test "should get new" do
    get new_airline_url
    assert_response :success
  end

  test "should create airline" do
    assert_difference('Airline.count') do
      post airlines_url, params: { airline: { alias: @airline.alias, callsign: @airline.callsign, country: @airline.country, customer: @airline.customer, description: @airline.description, iata_code: @airline.iata_code, icao_code: @airline.icao_code, name: @airline.name } }
    end

    assert_redirected_to airline_flights_path(Airline.last)
    assert @user.airlines.include? Airline.last
  end

  test "should show airline" do
    get airline_url(@airline)
    assert_response :success
  end

  test "should get edit" do
    get edit_airline_url(@airline)
    assert_response :success
  end

  test "should update airline" do
    patch airline_url(@airline), params: { airline: { alias: @airline.alias, callsign: @airline.callsign, country: @airline.country, customer: @airline.customer, description: @airline.description, iata_code: @airline.iata_code, icao_code: @airline.icao_code, name: @airline.name } }
    assert_redirected_to airlines_url
  end

  # TODO: Stub Test
  # test "should destroy airline" do
  #   assert_difference('Airline.count', -1) do
  #     delete airline_url(@airline)
  #   end
  #
  #   assert_redirected_to airlines_url
  # end
end
