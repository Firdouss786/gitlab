require 'application_system_test_case'

class ActivitiesTest < ApplicationSystemTestCase

  setup do
    @user = users(:chris)
    @station = stations(:lhr)
    browser_sign_in_as @user
  end

  test 'changing aircraft selection should get related flights' do
    visit new_activity_path(station_id: @station.id)
    assert_no_selector ".flights_list"

    select aircrafts(:gstbc).tail, :from => "aircraft_id"
    assert_selector ".flight_card", count: aircrafts(:gstbc).flights.arrived.where(destination_airport: @user.stations.map { |s| s.airport }).limit(5).count

    select aircrafts(:gstbe).tail, :from => "aircraft_id"
    assert_selector ".flight_card", count: aircrafts(:gstbe).flights.arrived.where(destination_airport: @user.stations.map { |s| s.airport }).limit(5).count
  end

  test "should create activity via flight selection" do
    visit new_activity_path(station_id: @station.id)

    select aircrafts(:gstbe).tail, :from => "aircraft_id"
    click_button("Start Work Pack", :match => :first)

    assert_selector '[data-test-id="error_explanation"]', text: 'Activity was successfully created.'
  end

  test "should create activity via manual form" do
    visit new_activity_path(station_id: @station.id)

    select aircrafts(:gstbe).tail, :from => "aircraft_id"
    assert_selector("div span", text: "Select inbound flight", visible: :visible)

    find('div span', text: "enter details manually").click

    select airports(:jfk).iata_code, :from => "activity[inbound_airport_id]"
    fill_in "activity[inbound_flight_number]", with: '123'
    select airports(:cdg).iata_code, :from => "activity[outbound_airport_id]"
    fill_in "activity[outbound_flight_number]", with: '456'
    click_on "Create Activity"

    assert_selector '[data-test-id="error_explanation"]', text: 'Activity was successfully created.'
  end

  test "should get open_deferrals after create" do
    visit new_activity_path(station_id: @station.id)

    select aircrafts(:gstbe).tail, :from => "aircraft_id"
    assert_selector("div span", text: "Select inbound flight", visible: :visible)

    find('div span', text: "enter details manually").click

    select airports(:jfk).iata_code, :from => "activity[inbound_airport_id]"
    fill_in "activity[inbound_flight_number]", with: '123'
    select airports(:cdg).iata_code, :from => "activity[outbound_airport_id]"
    fill_in "activity[outbound_flight_number]", with: '456'
    click_on "Create Activity"

    assert_selector '[data-test-id="error_explanation"]', text: 'Activity was successfully created.'
    assert_selector '[data-test-id="item-reference"]', text: faults(:fault_deferral_three).logbook_reference
  end

end
