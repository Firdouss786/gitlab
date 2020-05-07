require 'test_helper'

class Stations::UserRoutingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:chris)
    @user = users(:chris)
    @station = stations(:lhr)
  end

  test "should get new" do
    get new_station_user_routing_url(@station)
    assert_response :success

    assert_select '#title h1', "LHR"
  end

  test "should route existing user" do
    post station_user_routings_url(@station), params: { user: { email: @user.email } }
    assert_redirected_to user_accesses_url(@user)
  end

  test "should route new user" do
    email = "new_user@thalesinflight.com"
    post station_user_routings_url(@station), params: { user: { email: email } }

    assert_redirected_to new_user_path(email: email)
    follow_redirect!

    assert_select '#user_email[value=?]', email
    assert_select '#user_secondary_email[value=?]', email
  end


end
