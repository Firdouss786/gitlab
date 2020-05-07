require 'test_helper'

class Flight::FactoryTest < ActiveSupport::TestCase

  setup do
    @url = 'http://flightxml.flightaware.com/json/FlightXML2/FlightInfoEx?ident='
  end

  test "should get collection of flights" do
    aircraft = aircrafts(:gstbc)
    stub_request(:any, (@url + aircraft.sanitized_for_api)).to_rack(FakeFlightAware)

    flight_collection = Flight::Factory.new(aircraft).flight_collection
    assert_equal 3, flight_collection.count
  end

  test "should get empty collection of flights" do
    aircraft = aircrafts(:N70020)
    stub_request(:any, (@url + aircraft.sanitized_for_api)).to_rack(FakeFlightAware)

    flight_collection = Flight::Factory.new(aircraft).flight_collection
    assert flight_collection.count, 0

    assert_no_difference 'Flight.count' do
      Flight::Factory.new(aircraft).call
    end
  end

  test "should upsert collection" do
    aircraft = aircrafts(:gstbc)
    stub_request(:any, (@url + aircraft.sanitized_for_api)).to_rack(FakeFlightAware)

    assert_difference 'Flight.count', 3 do
      Flight::Factory.new(aircraft).call
    end

    flight = Flight.last
    original_origin_code = flight.origin_airport_code
    new_origin_code = 'ABCDEF'

    assert_not_equal original_origin_code, new_origin_code

    flight.update!(origin_airport_code: new_origin_code)

    assert_no_difference 'Flight.count' do
      Flight::Factory.new(aircraft).call
    end

    assert_equal flight.reload.origin_airport_code, original_origin_code
  end

end
