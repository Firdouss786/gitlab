require 'test_helper'

class FlightSubscriptionsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in_as users(:chris)
    stub_request(:any, /flightxml.flightaware.com/).to_rack(FakeFlightAware)
  end

  test 'should get index' do
    get airline_flight_subscriptions_url(airlines(:baw))
    assert_response :success

    assert_select '.nav__leaf--active', 'Flight Subscriptions'
  end

  test 'should register subscription with flight service for all aircrafts of an airline' do
    airline = airlines(:baw)
    get airline_flight_subscriptions_url(airline)
    assert_response :success

    # Check total number of unsubscribed aircrafts first.
    assert_select 'a', count: 2, text: 'Subscribe Aircraft'

    get subscribe_all_aircrafts_airline_flight_subscriptions_path(airline)
    # Check that no aircraft is left for subscribing.
    assert_select 'a', count: 0, text: 'Subscribe Aircraft'
  end

  test 'should deregister subscription of an airline' do
    airline = airlines(:baw)
    subscription = flight_subscriptions(:subscribed)
    delete airline_flight_subscription_path(airline, subscription)
    assert_response :redirect
  end

end
