require 'test_helper'

class ActivityTest < ActiveSupport::TestCase

  setup do
    Current.user = users(:chris)
  end

  test "cannot transition activity from complete to active" do
    @activity = activities(:closed_wp)

    @activity.transition_to_state(:active)

    assert @activity.complete?
  end

  test "cannot transition activity from active to complete" do
    @activity = activities(:to_be_closed)

    @activity.transition_to_state(:complete)

    assert @activity.complete?
  end

  test "state is set to created after successful creation" do
    @activity = activities(:standard)
    new_activity = Activity.create(station: @activity.station, aircraft: @activity.aircraft, flight: flights(:in_air_one))
    assert new_activity.state == 'created'
  end

end
