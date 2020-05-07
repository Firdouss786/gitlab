require 'test_helper'

class Fault::DeferrableTest < ActiveSupport::TestCase

  setup do
    Current.user = users(:chris)
  end

  test "should defer fault" do
    fault = faults(:fault_opened_in_wp)
    assert_not fault.deferred?

    fault.defer reason: defer_reasons(:insufficient_time), mel_category: 'D'

    assert fault.active?
    assert fault.deferred?
    assert_equal defer_reasons(:insufficient_time), fault.defer_reason
    assert_equal 'D', fault.mel_cetegory
  end

  test "should not defer unless active" do

  end

  test "scope returns deferred faults" do
    assert_equal 11, Fault.deferred.count
  end

  test "scope returns non-deferred faults" do
    assert_equal 6, Fault.not_deferred.count
  end

end
