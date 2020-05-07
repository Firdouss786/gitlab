class Flight::Adapters::FlightAware::Collection
  include ActiveModel::Model
  include Flight::Adapters::FlightAware::ConnectionHandler

  def initialize(aircraft_reg)
    @aircraft_reg = aircraft_reg
  end

  def call
    flights = flight_collection
    flight_hashes = Array.new
    if flights.present?
      flights.each do |flight|
        flight_info_ex = Flight::Adapters::FlightAware::FlightInfoEx.new(flight_params(flight))
        flight_hashes << flight_info_ex.to_flight_hash if flight_info_ex.valid?
      end
    end
    flight_hashes
  end

  def flight_collection
    fetch_flights.try(:parsed_response).try(:[], "FlightInfoExResult").try(:[], "flights")
  end

  private

    def flight_params(flight)
      ActionController::Parameters.new(flight).permit(:faFlightID, :ident, :filed_departuretime, :actualdeparturetime, :estimatedarrivaltime,
        :actualarrivaltime, :origin, :destination)
    end

    def fetch_flights
      get "/FlightInfoEx?ident=#{@aircraft_reg}"
    end

end
