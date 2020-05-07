class Flight::Adapters::FlightAware::Registration
  include Flight::Adapters::FlightAware::ConnectionHandler

  def initialize(aircraft_tail)
    @aircraft_tail = aircraft_tail
  end

  # Must return hash with 'registered' boolean and subscription_id
  # ie {registered: true, subscription_id: 5}
  def register
    response = get("/SetAlert?channels=#{channels}&ident=#{@aircraft_tail}")
    {registered: response_status(response), subscription_id: alert_id(response)}
  end

  private

    def response_status(response)
      response.try(:success?)
    end

    def alert_id(response)
      ActionController::Parameters.new(response).permit(:SetAlertResult)[:SetAlertResult] rescue nil
    end

    def channels
      "{16 e_filed e_departure e_arrival e_diverted e_cancelled}"
    end

end
