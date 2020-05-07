require 'test_helper'

class AddressesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @address = addresses(:heathrow)
    sign_in_as users(:chris)
  end

  test "should get index" do
    get addresses_url
    assert_response :success
  end

  test "should get new" do
    get new_address_url
    assert_response :success
  end

  test "should create address" do
    assert_difference('Address.count') do
      post addresses_url, params: { address: { city: @address.city, country: @address.country, phone: @address.phone, state: @address.state, street1: @address.street1, street2: @address.street2, zip: @address.zip } }
    end

    assert_redirected_to address_url(Address.last)
  end

  test "should show address" do
    get address_url(@address)
    assert_response :success
  end

  test "should get edit" do
    get edit_address_url(@address)
    assert_response :success
  end

  test "should update address" do
    patch address_url(@address), params: { address: { city: @address.city, country: @address.country, phone: @address.phone, state: @address.state, street1: @address.street1, street2: @address.street2, zip: @address.zip } }
    assert_redirected_to address_url(@address)
  end

  # TODO: Stub Test
  # test "should destroy address" do
  #   assert_difference('Address.count', -1) do
  #     delete address_url(@address)
  #   end
  #
  #   assert_redirected_to addresses_url
  # end
end
