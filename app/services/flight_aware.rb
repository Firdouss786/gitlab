class FlightAware

  include HTTParty
  base_uri FLIGHT_AWARE_API_URL

  def self.get(path)
    publish_analytic(path)
    HTTParty.get(base_uri + path, options)
  end

  private
    def self.options
      { headers: {authorization: "Basic #{FLIGHT_AWARE_API_KEY}"} }
    end

    def self.authorized?
      response = get("/GetAlerts")
      response.header.to_s.include?("HTTPUnauthorized") ? false : true
    end

    def self.register_endpoint
      response = get("/RegisterAlertEndpoint?address=#{FIREFLY_NOTIFICATIONS_ENDPOINT}&format_type=json/post")
      result = JSON.parse(response.body)["RegisterAlertEndpointResult"]

      result == 1 ? true : false
    end

    def self.flush_all_alerts
      response = get("/GetAlerts")

      response["GetAlertsResult"]["alerts"].each do |alert|
        puts "Flushing alert ID #{alert["alert_id"]}"
        get("/DeleteAlert?alert_id=#{alert["alert_id"]}")
      end
    end

    def self.publish_analytic(path)
      api_name = path.split("?").first[1..-1] # ie "GetAlerts"

      Flight::Analytic.publish_event(endpoint: api_name)
    end

    def self.initialize_flight(flight_object:, aircraft:, event_code: nil, summary: nil, short_desc: nil)
      Flight::Analytic.publish_event(aircraft: aircraft, endpoint: "PushAlert")

      flight = Flight.where(vendor_id: flight_object["faFlightID"]).first_or_initialize

      flight.vendor_id                      = flight_object["faFlightID"]
      flight.flight_number                  = flight_object["ident"]
      flight.aircraft_type                  = flight_object["aircrafttype"]
      flight.tail_number                    = flight_object["reg"]
      flight.origin_airport_code            = flight_object["origin"]
      flight.origin_airport_name            = flight_object["originName"]
      flight.origin_city_name               = flight_object["originCity"]
      flight.destination_airport_code       = flight_object["destination"]
      flight.destination_airport_name       = flight_object["destinationName"]
      flight.destination_city_name          = flight_object["destinationCity"]
      flight.aircraft                       = aircraft
      flight.airline                        = aircraft.airline
      flight.origin_airport                 = airport_for(flight_object["origin"])
      flight.destination_airport            = airport_for(flight_object["destination"])
      flight.event_code                     = event_code
      flight.summary                        = summary
      flight.short_desc                     = short_desc
      flight.filed_departure_time           = convert_date(flight_object["filed_departuretime"])
      flight.actual_departure_time          = convert_date(flight_object["actualdeparturetime"])
      flight.filed_blockout_time            = convert_date(flight_object["filed_blockout_time"])
      flight.estimated_blockout_time        = convert_date(flight_object["estimated_blockout_time"])
      flight.actual_blockout_time           = convert_date(flight_object["actual_blockout_time"])
      flight.filed_arrival_time             = convert_date(flight_object["filed_arrivaltime"])
      flight.estimated_arrival_time         = convert_date(flight_object["estimatedarrivaltime"])
      flight.actual_arrival_time            = convert_date(flight_object["actualarrivaltime"])
      flight.filed_blockin_time             = convert_date(flight_object["filed_blockin_time"])
      flight.estimated_blockin_time         = convert_date(flight_object["estimated_blockin_time"])
      flight.actual_blockin_time            = convert_date(flight_object["actual_blockin_time"])

      flight
    end

    def self.convert_date(response_integer)
      if response_integer
        response_integer > 0 ? Time.at(response_integer).utc : nil
      end
    end

    def self.airport_for(icao_code)
      Airport.find_or_create_by(icao_code: icao_code)
    end
end
