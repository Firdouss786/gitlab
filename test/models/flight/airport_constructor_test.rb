require 'test_helper'

class Flight::AirportConstructorTest < ActiveSupport::TestCase

  setup do
    stub_request(:any, /flightxml.flightaware.com/).to_rack(FakeFlightAware)
  end

  test "should get airport" do
    assert_difference "Airport.count" do
      Flight::AirportConstructor.new("ULLI").call
    end
  end

  # TODO
  # test "should gracefully handle unfound icao code" do
  #   assert_no_difference "Airport.count" do
  #     Flight::AirportConstructor.new("FAKE").call
  #   end
  # end

end
