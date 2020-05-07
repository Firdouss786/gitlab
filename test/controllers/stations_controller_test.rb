require 'test_helper'

class StationsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in_as users(:chris)
    @station = stations(:lhr)
  end

  test "should get index" do
    get stations_url
    assert_response :success
  end

  test "should get new" do
    get new_station_url
    assert_response :success
  end

  test "should create station" do
    assert_difference('Station.count') do
      post stations_url, params: { station: { airport_id: @station.airport_id, name: 'ABC', user_id: @station.user_id, address_attributes: { street1: @station.address.street1, city: @station.address.city, zip: @station.address.zip, country: @station.address.country, phone: @station.address.phone } } }
    end

    assert_redirected_to stations_url
  end

  test "should show station" do
    get station_url(@station)
    assert_response :success
  end

  test "should get edit" do
    get edit_station_url(@station)
    assert_response :success
  end

  test "should update station" do
    patch station_url(@station), params: { station: { name: 'XYZ' } }
    assert_redirected_to stations_url
  end

  # test "should destroy station" do
  #   @station = stations(:station_delete)
  #   assert_difference('Station.count', -1) do
  #     delete station_url(@station)
  #   end

  #   assert_redirected_to stations_url
  # end

end
