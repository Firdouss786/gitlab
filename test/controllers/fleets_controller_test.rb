require 'test_helper'

class FleetsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in_as users(:chris)
    @fleet = fleets(:B777)
    @airline = @fleet.airline
  end

  test "should get index" do
    get airline_fleets_url(@airline)
    assert_response :success
  end

  test "should get new" do
    get new_airline_fleet_url(@airline)
    assert_response :success
  end

  test "should create fleet" do
    assert_difference('Fleet.count') do
      post airline_fleets_url(@airline), params: { fleet: { aircraft_type_id: @fleet.aircraft_type_id, airline_id: @fleet.airline_id, business_class_seat_count: @fleet.business_class_seat_count, description: @fleet.description, economy_class_seat_count: @fleet.economy_class_seat_count, first_class_seat_count: @fleet.first_class_seat_count, install_type: @fleet.install_type, lopa_path: @fleet.lopa_path, name: @fleet.name, premium_class_seat_count: @fleet.premium_class_seat_count, software_platform_id: @fleet.software_platform_id } }
    end

    assert_redirected_to airline_fleets_url(@airline)
  end

  test "should show fleet" do
    get airline_fleet_url(@airline, @fleet)
    assert_response :success
  end

  test "should get edit" do
    get edit_airline_fleet_url(@airline, @fleet)
    assert_response :success
  end

  test "should update fleet" do
    patch airline_fleet_url(airline_id: @airline, id: @fleet), params: { fleet: { aircraft_type_id: @fleet.aircraft_type_id, airline_id: @fleet.airline_id, business_class_seat_count: @fleet.business_class_seat_count, description: @fleet.description, economy_class_seat_count: @fleet.economy_class_seat_count, first_class_seat_count: @fleet.first_class_seat_count, install_type: @fleet.install_type, lopa_path: @fleet.lopa_path, name: @fleet.name, premium_class_seat_count: @fleet.premium_class_seat_count, software_platform_id: @fleet.software_platform_id } }
    assert_redirected_to airline_fleets_path(@fleet.airline)
  end

  # TODO: Stub Test
  # test "should destroy fleet" do
  #   assert_difference('AircraftConfig.count', -1) do
  #     delete fleet_url(@fleet)
  #   end
  #
  #   assert_redirected_to fleets_url
  # end
end
