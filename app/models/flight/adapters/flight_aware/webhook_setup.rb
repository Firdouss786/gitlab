class Flight::Adapters::FlightAware::WebhookSetup
  include Flight::Adapters::FlightAware::ConnectionHandler

  def initialize(endpoint)
    @endpoint = endpoint
  end

  # Should return true or false
  def call
    response = get("/RegisterAlertEndpoint?address=#{@endpoint}&format_type=json/post")
    return response unless response.code == 200
    result = JSON.parse(response.body)["RegisterAlertEndpointResult"]
    result == 1 ? true : unsuccessful_setup
  end

  def unsuccessful_setup
    Rails.logger.error "The endpoint registation was unsuccessfull"
    false
  end

end
