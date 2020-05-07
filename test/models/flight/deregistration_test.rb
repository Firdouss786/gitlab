require 'test_helper'

class Flight::DeregistrationTest < ActionDispatch::IntegrationTest

  setup do
    stub_request(:any, /flightxml.flightaware.com/).to_rack(FakeFlightAware)
  end

  test 'flight deregistration' do
    subscription = flight_subscriptions(:subscribed)
    assert subscription.subscribed?

    Flight::Deregistration.new(subscription).deregister
    assert subscription.destroyed?
  end

end
