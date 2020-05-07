require 'test_helper'

class Flight::WebhookSetupTest < ActiveSupport::TestCase

	setup do
	  @url = 'http://flightxml.flightaware.com/json/FlightXML2/RegisterAlertEndpoint?address=https://firefly.staging.topcareife.com/flight_notifications&format_type=json/post'
	end

	test "registering the end point" do
		stub_request(:get, @url).to_rack(FakeFlightAware)
		result = Flight::WebhookSetup.new.call
		assert_equal result, true
	end

	test "not able to register the endpoint" do
		ENV["REQUEST"] = "unsuccessful"
		stub_request(:get, @url).to_rack(FakeFlightAware)
		result = Flight::WebhookSetup.new.call
		assert_equal result, false
	end

end
