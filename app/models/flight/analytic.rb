class Flight::Analytic

  Keen.project_id = Rails.application.credentials.keen_project_id
  Keen.write_key = Rails.application.credentials.keen_write_key

  def self.publish_event(aircraft: nil, fa_api_version: "2.0", endpoint:)
    # Keen.publish(:fa_xml_queries, {
    #   aircraft_registration: aircraft.try(:registration),
    #   aircraft_id: aircraft.try(:id),
    #   airline_icao_code: aircraft.try(:airline).try(:icao_code),
    #   fa_api_version: fa_api_version,
    #   endpoint: endpoint,
    #   environment: Rails.env,
    #   application_version: Firefly::VERSION,
    #   cost: cost_for(endpoint)
    # })
  end

  private
    def self.cost_for(endpoint)
      pricing = {
        "AirlineFlightSchedules": 0.0070,
        "AirlineInsight": 0.0070,
        "MapFlight": 0.0070,
        "MapFlightEx": 0.0070,
        "SearchBirdseyeInFlight": 0.0070,
        "SearchBirdseyePositions": 0.0070,
        "AirlineFlightInfo": 0.0046,
        "AllAirports": 0.0046,
        "Arrived": 0.0046,
        "CountAirportOperations": 0.0046,
        "DecodeFlightRoute": 0.0046,
        "DecodeRoute": 0.0046,
        "Departed": 0.0046,
        "Enroute": 0.0046,
        "FleetArrived": 0.0046,
        "FlightInfo": 0.0046,
        "GetHistoricalTrack": 0.0046,
        "GetLastTrack": 0.0046,
        "InFlightInfo": 0.0046,
        "InboundFlightInfo": 0.0046,
        "PushAlert": 0.0046,
        "RoutesBetweenAirports": 0.0046,
        "RoutesBetweenAirportsEx": 0.0046,
        "Scheduled": 0.0046,
        "Search": 0.0046,
        "SearchCount": 0.0046,
        "AircraftType": 0.0012,
        "AirportInfo": 0.0012,
        "AllAirlines": 0.0012,
        "BlockIdentCheck": 0.0012,
        "CountAllEnrouteAirlineOperations": 0.0012,
        "DeleteAlert": 0.0012,
        "FleetScheduled": 0.0012,
        "FlightInfoEx": 0.0012,
        "GetAlerts": 0.0012,
        "Metar": 0.0012,
        "NTaf": 0.0012,
        "SetAlert": 0.0012,
        "Taf": 0.0012,
        "TailOwner": 0.0012,
        "AirlineInfo": 0.0005,
        "GetFlightID": 0.0005,
        "LatLongsToDistance": 0.0005,
        "LatLongsToHeading": 0.0005,
        "MetarEx": 0.0005,
        "ZipcodeInfo": 0.0005,
        "RegisterAlertEndpoint": 0.0,
        "SetMaximumResultSize": 0.0
      }

      pricing[endpoint.to_sym] ||= 0.0
    end

end
