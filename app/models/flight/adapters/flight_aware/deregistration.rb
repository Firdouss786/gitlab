class Flight::Adapters::FlightAware::Deregistration
  include Flight::Adapters::FlightAware::ConnectionHandler

  def initialize(subscription)
    @subscription = subscription
  end

  def deregister
    response = get("/DeleteAlert?alert_id=#{@subscription.vendor_subscription_id}")
    response_status(response)
  end

  private

    def response_status(response)
      response.try(:success?) && response_data(response) == 1
    end

    def response_data(response)
      ActionController::Parameters.new(response).permit(:DeleteAlertResult)[:DeleteAlertResult] rescue nil
    end

end
