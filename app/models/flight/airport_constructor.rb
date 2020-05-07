class Flight::AirportConstructor

  def initialize(airport_icao_code)
    @airport_icao_code = airport_icao_code
  end

  def call
    Airport.create(fetch_airport.as_json.merge(iata_code: @airport_icao_code, icao_code: @airport_icao_code))
  end

  def fetch_airport
    airport_construction_adapter.new(@airport_icao_code).call
  end

  private

    def airport_construction_adapter
      Flight::Adapters::FlightAware::AirportConstructor
    end

end
