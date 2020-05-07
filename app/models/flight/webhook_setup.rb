class Flight::WebhookSetup

  def initialize(endpoint = "https://firefly.staging.topcareife.com/flight_notifications")
    @endpoint = endpoint
  end

  def call
    webhook_setup_adapter.new(@endpoint).call
  end

  private

    def webhook_setup_adapter
      Flight::Adapters::FlightAware::WebhookSetup
    end

end
