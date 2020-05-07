class Flight::Adapters::FlightAware::AirportConstructor
  include ActiveModel::Model
  include Flight::Adapters::FlightAware::ConnectionHandler

  def initialize(airport_icao_code)
    @airport_icao_code = airport_icao_code
  end

  def call
    Flight::Adapters::FlightAware::AirportInfo.new(airport_params(fetch_airport))
  end

  private

    def airport_params(airport)
      ActionController::Parameters.new(airport).require("AirportInfoResult").permit(:name, :latitude, :longitude, :timezone, :location)
    end

    def fetch_airport
      get("/AirportInfo?airportCode=#{@airport_icao_code}")
    end

end
