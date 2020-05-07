require 'test_helper'

class AircraftTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @aircraft_type = aircraft_types(:B777200)
    sign_in_as users(:chris)
  end

  test "should get index" do
    get aircraft_types_url
    assert_response :success
  end

  test "should get new" do
    get new_aircraft_type_url
    assert_response :success
  end

  test "should create aircraft_type" do
    assert_difference('AircraftType.count') do
      post aircraft_types_url, params: { aircraft_type: { description: @aircraft_type.description, manufacturer_id: @aircraft_type.manufacturer_id, name: @aircraft_type.name } }
    end

    assert_redirected_to aircraft_type_url(AircraftType.last)
  end

  test "should show aircraft_type" do
    get aircraft_type_url(@aircraft_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_aircraft_type_url(@aircraft_type)
    assert_response :success
  end

  test "should update aircraft_type" do
    patch aircraft_type_url(@aircraft_type), params: { aircraft_type: { description: @aircraft_type.description, manufacturer_id: @aircraft_type.manufacturer_id, name: @aircraft_type.name } }
    assert_redirected_to aircraft_type_url(@aircraft_type)
  end

  # TODO: Stub Test
  # test "should destroy aircraft_type" do
  #   assert_difference('AircraftType.count', -1) do
  #     delete aircraft_type_url(@aircraft_type)
  #   end
  #
  #   assert_redirected_to aircraft_types_url
  # end
end
