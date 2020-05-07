require 'test_helper'

class Flight::InformActivityTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:chris)
  end

  test "create activity after flight is created, and flight is landing in the future" do
    assert_difference('Activity.count') do
      new_flight = flights(:tbd_inbound_to_lhr).dup
      new_flight.vendor_id = "vendor_id_must_be_unique_123123"
      new_flight.save
    end

    assert_equal Activity.last.station, flights(:tbd_inbound_to_lhr).destination_airport.station
    assert_equal Activity.last.aircraft, flights(:tbd_inbound_to_lhr).aircraft
    assert Activity.last.created?
  end

  test "create activity after flight is updated" do
    assert_difference('Activity.count') do
      new_flight = flights(:tbd_inbound_to_lhr).dup
      new_flight.vendor_id = "vendor_id_must_be_unique_123123123"
      new_flight.save
    end

    assert_equal Activity.last.station, flights(:tbd_inbound_to_lhr).destination_airport.station
    assert_equal Activity.last.aircraft, flights(:tbd_inbound_to_lhr).aircraft
    assert Activity.last.created?
  end

  test "dont create activity if flight destination is unmanned" do
    assert_no_difference('Activity.count') do
      new_flight = flights(:flight_to_unmanned_airport).dup
      new_flight.vendor_id = "vendor_id_must_be_unique_678678"
      new_flight.save
    end
  end

  test "don't create activity if flight is not enroute" do
    assert_no_difference('Activity.count') do
      new_flight = flights(:tbd_outbound_from_lhr).dup
      new_flight.vendor_id = "vendor_id_must_be_unique_456456"
      new_flight.save
    end
  end

end
