require 'test_helper'

class Users::AccessesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:chris)
  end

  test "should get index" do
    get user_accesses_path(users(:chris))
    assert_response :success
    assert_select '.nav__leaf--active', "Access"
  end

  test "should update users accesses" do
    assert_equal 3, users(:chris).accesses.count
    patch user_accesses_url(users(:chris)), params: { user: { all_airline_ids: [airlines(:baw).id, airlines(:aal).id, airlines(:jbu).id], all_station_ids: [stations(:lhr).id] } }
    assert_equal 4, users(:chris).accesses.count
  end

  # Disabled this feature as it needs more thorough QA testing - Chris Dec 17 2019
  # test "should request approval if user is not an admin" do
  #   sign_in_as users(:maaz)
  #   assert_difference("Approval.count", 2) do
  #     patch user_accesses_url(users(:maaz)), params: { user: { all_airline_ids: [airlines(:baw).id], all_station_ids: [stations(:lax).id]} }
  #     assert_not Access.last.enabled?
  #   end
  # end
  #
  # test "should NOT request approval if user is an admin" do
  #   sign_in_as users(:chris)
  #
  #   assert_no_difference("Approval.count") do
  #     patch user_accesses_url(users(:maaz)), params: { user: { all_airline_ids: [airlines(:baw).id], all_station_ids: [stations(:lax).id] } }
  #   end
  # end
  #
  # test "requestee and approvers are correct" do
  #   sign_in_as users(:maaz)
  #
  #   patch user_accesses_url(users(:maaz)), params: { user: { all_airline_ids: [airlines(:baw).id], all_station_ids: [stations(:lax).id] } }
  #
  #   assert_equal users(:maaz), Approval.last.requestee
  #   assert_equal users(:albert), Approval.last.users.first
  # end

  test 'should allow user to change their default airline' do
    sign_in_as users(:chris)
    assert_equal airlines(:baw), users(:chris).default_airline

    patch user_accesses_url(users(:chris)), params: { user: { default_airline_id: airlines(:aal).id, all_airline_ids: [airlines(:aal).id, airlines(:baw).id], all_station_ids: [stations(:lhr).id]  } }
    assert_equal airlines(:aal), users(:chris).reload.default_airline
  end


  test 'should allow user to change their default station' do
    sign_in_as users(:chris)
    assert_equal stations(:lhr), users(:chris).home_station

    patch user_accesses_url(users(:chris)), params: { user: { home_station_id: stations(:lax).id, all_airline_ids: [airlines(:aal).id,airlines(:baw).id], all_station_ids: [stations(:lhr).id, stations(:lax).id] } }
    assert_equal stations(:lax), users(:chris).reload.home_station
  end
end
