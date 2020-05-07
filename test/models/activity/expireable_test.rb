require 'test_helper'

class Activity::ExpireableTest < ActiveSupport::TestCase

  setup do
    Current.user = users(:chris)
  end

  test "should expire created activity" do
    assert_difference('Activity.count', -1) do
      activities(:created_empty).expire!
    end
  end

  test "should not expire active activity" do
    assert_no_difference('Activity.count') do
      activities(:open_wp).expire!
    end
  end

end
