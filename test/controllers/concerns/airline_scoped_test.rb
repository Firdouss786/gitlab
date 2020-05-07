require 'test_helper'

class AirlineScopedTest < ActionDispatch::IntegrationTest
  setup do
  end

  test "Kathrine (technician) should be able to access BAW (one of her airlines)" do
    sign_in_as users(:kathrine)

    get airline_path(airlines(:baw))

    assert_select '#title h1', "British Airways"
  end

  test "Katherine should have access to an airlines nested resources" do
    sign_in_as users(:kathrine)

    get airline_flight_subscriptions_path(airlines(:baw))

    assert_select '.nav__leaf--active', "Flight Subscriptions"
  end

  test "Kathrine should be denied access to AAL" do
    sign_in_as users(:kathrine)

    get airline_path(airlines(:aal))

    follow_redirect!

    assert_select 'h2', "You do not have access to American Airlines"
  end

  test "Kathrine should be denied access to AAL's nested resources" do
    sign_in_as users(:kathrine)

    get airline_flight_subscriptions_path(airlines(:aal))

    follow_redirect!

    assert_select 'h2', "You do not have access to American Airlines"
  end

  test "Kathrine should be able to see the list of airlines" do
    sign_in_as users(:kathrine)

    get airlines_path

    assert_select '.nav__leaf--active', "Airlines"
  end


end
