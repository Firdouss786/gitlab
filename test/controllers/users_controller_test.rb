require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include ActionMailer::TestHelper

  setup do
    @technician_at_lhr = users(:chris)
    @manager_at_lax = users(:maaz)
    sign_in_as @technician_at_lhr
  end

  test "invalid signup information" do
    assert_no_difference 'User.count' do
      post users_path, params: { user: { first_name:  "Chris", last_name: "", email: "user@invalid.com", profile_id: profiles(:technician).id,phone_number: "123!456*7890",country_code: "United Stated  +1" } }
    end

    assert_select "[data-test-id='error_explanation']", text: "Last name can't be blank"
  end

  test "valid signup information" do
    assert_difference 'User.count' do
      post users_path, params: { user: { first_name:  "Chris", last_name: "Swann", email: "user@thalesinflight.com", profile_id: profiles(:technician).id, home_station_id: stations(:lhr).id, default_airline_id: airlines(:baw).id, phone_number: "123-456-7890", country_code: "GBR" } }
    end

    assert_redirected_to edit_user_path(User.last)
  end

  test "incorrect email " do
    assert_no_difference 'User.count' do
      post users_path, params: { user: { first_name:  "Chris", last_name: "Swann", email: "user@gmail.com", profile_id: profiles(:technician).id } }
    end
  end

  test "should get edit" do
    get edit_user_url(@technician_at_lhr)
    assert_response :success
  end

  test "new user should be emailed their details" do
    assert_enqueued_emails 1 do
      post users_path, params: { user: { first_name:  "Chris", last_name: "Swann", email: "user@thalesinflight.com", password: "JohnSmith01!", profile_id: profiles(:technician).id, home_station_id: stations(:lhr).id, default_airline_id: airlines(:baw).id, phone_number: "123-456-7890", country_code: "United Stated  +1" } }
    end
  end

  test "should get correct number of users" do
    get station_users_path stations(:lhr)
    assert_response :success
    assert_select '[data-test-id="user-row"]', 3
  end

  test "should get correct number of archived users" do
    get archived_station_users_path stations(:lhr)
    assert_response :success
    assert_select '[data-test-id="user-row"]', 1
  end

  test "user with no phone number should not get call button" do
    @technician_at_lhr.update({phone_number: ""})
    assert get station_users_path(@technician_at_lhr.home_station)
    assert_response :success
    assert_select '[data-test-id="user-phone"]', @technician_at_lhr.home_station.users.unlocked.where("phone_number <> ''").count
  end

  test "new user should have default airline and station access " do
    sign_in_as users(:john)
    assert_equal 0, users(:maaz).accesses.count
    assert_difference 'User.count' do
      post users_path, params: { user: { first_name: "Maaz", last_name: "Siddiqui", email: "test@thalesinflight.com", profile_id: profiles(:technician).id, home_station_id: stations(:lax).id, default_airline_id: airlines(:baw).id, phone_number: "123-456-7890", country_code: "GBR" } }
      Access.find_or_create_by({:user => users(:maaz), :accessible_type => "Station", :accessible_id => Station.first.id})
      Access.find_or_create_by({:user => users(:maaz), :accessible_type => "Airline", :accessible_id => Airline.first.id})
    end

    assert_equal 2, users(:maaz).accesses.count
  end
end
