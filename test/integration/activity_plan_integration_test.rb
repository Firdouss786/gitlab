require 'test_helper'

class ActivityPlanIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:chris)
  end

  test "Should create activity plan after flight is created" do
    assert_difference('ActivityPlan.count') do
      flights(:in_air_one).dup.save
    end

    assert_equal ActivityPlan.last.station, flights(:in_air_one).destination_airport.station
    assert ActivityPlan.last.created?
  end

  test "Should destroy and recreate activity plan after aircraft update" do
    assert_difference('ActivityPlan.count') do
      flights(:in_air_one).dup.save
    end

    previous_acivity_plan = ActivityPlan.last.id
    ActivityPlan.last.flight.update(aircraft: aircrafts(:gstbe))
    assert previous_acivity_plan != ActivityPlan.last.id
    assert_nil ActivityPlan.find_by_id(previous_acivity_plan)
  end

  test "Should destroy and recreate activity plan after destination airport update" do
    assert_difference('ActivityPlan.count') do
      flights(:in_air_one).dup.save
    end

    previous_acivity_plan = ActivityPlan.last.id
    ActivityPlan.last.flight.update(destination_airport: airports(:jfk))
    assert previous_acivity_plan != ActivityPlan.last.id
    assert_nil ActivityPlan.find_by_id(previous_acivity_plan)
  end

  test "Should destroy and recreate activity plan after arrival time exceeds limit" do
    assert_difference('ActivityPlan.count') do
      flights(:in_air_one).dup.save
    end

    previous_acivity_plan = ActivityPlan.last.id
    ActivityPlan.last.flight.update(filed_arrival_time: ActivityPlan.last.flight.runway_arrival + 7.hours)
    assert previous_acivity_plan != ActivityPlan.last.id
    assert_nil ActivityPlan.find_by_id(previous_acivity_plan)
  end

end
