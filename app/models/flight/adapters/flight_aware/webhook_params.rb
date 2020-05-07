class Flight::Adapters::FlightAware::WebhookParams

  def initialize(params)
    @params = params
  end

  def call
    @params[:alert_id]
  end

end
