require 'test_helper'

class ActivitiesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @activity = activities(:open_wp)
    @aircraft = aircrafts(:gstbe)
    @flight = flights(:on_ground_two)
    @station = stations(:lhr)
    sign_in_as users(:chris)
  end

  test "should show activity" do
    get activity_url(@activity)
    assert_response :success
  end

  test "should get edit" do
     get edit_activity_path(@activity)
     assert_response :success
  end

  test "should show activity with the flight enroute" do
    get station_activities_path(@station), params: { filter: "arriving" }
    assert_response :success

    assert_select '.table-row', count: 1
    assert_select '.table-row', /enroute/
  end

  test "should show activity with the flight landed" do
    get station_activities_path(@station), params: { filter: "landed" }
    assert_response :success

    assert_select '.table-row', count: 1
    assert_select '.table-row', /arrived/
  end

  test "should update activity except aircraft and station" do
    patch activity_path(@activity), params: { activity: { flight: nil, inbound_flight_number: '123', inbound_airport: airports(:jfk), outbound_airport: airports(:lga), outbound_flight_number: '456' } }
    assert_redirected_to @activity
  end

  test "should get new with no aircraft selected" do
    get new_station_activity_path(@station)
    assert_response :success
    assert_select "h2", "Tail"
  end

  test "Should see existing activities when creating a new work pack" do
    get new_station_activity_path(@station), params: { aircraft_id: aircrafts(:gstbb).id }
    assert_response :success
    assert_select ".table-row", 2
  end

  test "should create new workpack via flight selection" do
    assert_difference('Activity.count') do
      post station_activities_path(@station), params: { activity: { boarded_at: Time.now, aircraft_id: aircrafts(:gstbe).id, flight_id: @flight.id } }
    end

    assert_redirected_to activity_path Activity.last.id
    follow_redirect!

    assert_select "[data-test-id='aircraft_reg_and_nose']", "#{aircrafts(:gstbe).airline.icao_code} #{aircrafts(:gstbe).reg_and_nose}"
  end

  test "should create new workpack via manual form" do
    assert_difference('Activity.count') do
      post station_activities_path(@station), params: { activity: { boarded_at: Time.now, aircraft_id: aircrafts(:gstbe).id, inbound_airport_id: airports(:jfk).id, inbound_flight_number: "123", outbound_airport_id: airports(:jfk).id, outbound_flight_number: "123" } }
    end

    assert_redirected_to activity_path Activity.last.id
    follow_redirect!

    assert_select "[data-test-id='aircraft_reg_and_nose']", "#{aircrafts(:gstbe).airline.icao_code} #{aircrafts(:gstbe).reg_and_nose}"
  end

  test "should open work pack and add additional attributes" do
    @activity = activities(:with_inbound_flight)
    assert @activity.created?
    assert_nil @activity.boarded_at
    assert_nil @activity.inbound_flight_number
    assert_nil @activity.inbound_airport_id
    assert_nil @activity.outbound_airport_id
    assert_nil @activity.outbound_flight_number

    get open_activity_url @activity
    assert_redirected_to @activity

    @flight = @activity.reload.flight
    @next_flight = @flight.next_flight

    assert @activity.active?
    assert @activity.boarded_at.present?
    assert @activity.inbound_flight_number == @flight.flight_number
    assert @activity.inbound_airport_id == @flight.origin_airport_id
    assert @activity.outbound_airport_id == @next_flight.destination_airport_id
    assert @activity.outbound_flight_number == @next_flight.flight_number
  end

  test "should return filter results" do
    get station_activities_path(@station), params: { q: "G-STBC" }
    assert_response :success
    assert_select ".table-row", 1
  end

  test "should return partial search results" do
    get station_activities_path(@station), params: { q: "G-ST" }
    assert_response :success
    assert_select ".table-row", 5
  end

  test "should returns empty results" do
    get station_activities_path(@station), params: { q: "ABC" }
    assert_response :success
    assert_select ".table-row", 0
  end

  # test "should destroy activity" do
  #   assert_difference('Activity.count', -1) do
  #     delete activity_url(@activity)
  #   end
  #
  #   assert_redirected_to activities_url
  # end

end
