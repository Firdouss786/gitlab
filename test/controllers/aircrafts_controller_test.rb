require 'test_helper'

class AircraftsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @aircraft = aircrafts(:gstba)
    @fleet = @aircraft.fleet
    @airline = @fleet.airline
    sign_in_as users(:chris)
  end

  test "should get index" do
    get aircrafts_url(@fleet)
    assert_response :success
  end

  test "should get new" do
    get new_aircraft_url(@fleet)
    assert_response :success
  end

  test "should create aircraft" do
    assert_difference('Aircraft.count') do
      post aircrafts_url(@fleet), params: { aircraft: { active: @aircraft.active, airline_id: @aircraft.airline_id, fleet_id: @aircraft.fleet_id, description: @aircraft.description, eis: @aircraft.eis, fin: @aircraft.fin, locked: @aircraft.locked, msn: @aircraft.msn, registration: @aircraft.registration, tail: @aircraft.tail, tot: @aircraft.tot } }
    end

    assert_redirected_to aircrafts_path(@fleet)
  end

  test "should show aircraft" do
    get aircraft_url(@fleet, @aircraft)
    assert_response :success
  end

  test "should get edit" do
    get edit_aircraft_url(@fleet, @aircraft)
    assert_response :success
  end

  test "should update aircraft" do
    patch aircraft_url(@fleet, @aircraft), params: { aircraft: { active: @aircraft.active, airline_id: @aircraft.airline_id, fleet_id: @aircraft.fleet_id, description: @aircraft.description, eis: @aircraft.eis, fin: @aircraft.fin, locked: @aircraft.locked, msn: @aircraft.msn, registration: @aircraft.registration, tail: @aircraft.tail, tot: @aircraft.tot } }
    assert_redirected_to aircrafts_url(@fleet)
  end

  # test "should destroy aircraft" do
  #   assert_difference('Aircraft.count', -1) do
  #     delete aircraft_url(@aircraft)
  #   end
  #
  #   assert_redirected_to aircrafts_url
  # end
end
