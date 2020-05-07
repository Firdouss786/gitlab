require 'test_helper'

class FlightNotificationsControllerTest < ActionDispatch::IntegrationTest

  setup do
  end

  test "When receiving a payload from the flight vendor, look up the subscription and enqueue the FetchFlightDataJob" do
    assert_enqueued_with(job: FetchFlightDataJob) do
      receive_webhook(:filed)
    end
  end

  test "if the vendor_subscription_id is missing from the params, it should be handled gracefully" do
    receive_webhook(:without_alert_id)
    assert_response :ok
  end

  test "if the subscription can't be found, it should be handled gracefully" do
    receive_webhook(:invalid_alert_id)
    assert_response :ok
  end

  test "execute create action if flight data feature is set to true" do
    assert_enqueued_with(job: FetchFlightDataJob) do
      receive_webhook(:filed)
      assert_response :ok
    end
  end

  test "prevent execution of create action if flight data feature is set to false" do
    FeatureFlag.where(name: "flight_data").first.update(enabled: false)
    receive_webhook(:filed)
    assert_response :no_content
  end

  private
    def receive_webhook(payload_type)
      file = File.read("test/fixtures/flight_data/#{payload_type.to_s}.json")
      data_hash = JSON.parse(file)

      post '/flight_notifications', params: data_hash, as: :json
    end
end
