require 'test_helper'

class Flight::RegistrationTest < ActiveSupport::TestCase

  setup do
    @subscription = Flight::Subscription.new(aircraft: aircrafts(:gstbc))
    @vendor_id = 29302688
    stub_request(:any, /flightxml.flightaware.com/).to_rack(FakeFlightAware)
  end

  test "flight registration" do
    Flight::Registration.new(@subscription).register

    assert @subscription.reload.subscribed?
    assert_equal @vendor_id, @subscription.vendor_subscription_id
  end

end
