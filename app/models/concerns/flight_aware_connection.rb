module FlightAwareConnection
  extend ActiveSupport::Concern

  included do
    FLIGHT_AWARE_API_URL = 'http://flightxml.flightaware.com/json/FlightXML2'
    FLIGHT_AWARE_API_KEY = Rails.application.credentials.fa_xml_key

    def self.query(aircraft)
      if flights = flights_for_aircraft(aircraft)
        flights.each do |flight|
          payload = extract_payload_from_flight(aircraft, flight)

          record = find_or_initialize_by(
            vendor_id: payload[:vendor_id]
          )

          record.assign_attributes(payload)
          associate_and_save(record, aircraft) if record.changed?
        end
      else
        Rails.logger.warn "Unable to get flight data for aircraft #{aircraft.sanitized_for_api}"
      end
    end

    private

      def self.flights_for_aircraft(aircraft)
        response = HTTParty.get("#{FLIGHT_AWARE_API_URL}/FlightInfoEx?ident=#{aircraft.sanitized_for_api}", headers: {authorization: "Basic #{FLIGHT_AWARE_API_KEY}"})
        Flight::Analytic.publish_event(query_type: "get", aircraft: aircraft, endpoint: "FlightInfoEx")
        extract_flights response
      end

      def self.extract_flights(response)
        if response && response["FlightInfoExResult"] && response["FlightInfoExResult"]["flights"]
          response["FlightInfoExResult"]["flights"]
        end
      end

      def self.extract_payload_from_flight(aircraft, flight)
        {
          vendor_id: trim_vendor_id(flight["faFlightID"]),
          flight_number: flight["ident"],
          tail_number: aircraft.sanitized_for_api,
          aircraft_type: flight["aircrafttype"],
          departure_airport_code: flight["origin"],
          departure_airport_name: flight["originName"],
          departure_city_name: flight["originCity"],
          arrival_airport_code: flight["destination"],
          arrival_airport_name: flight["destinationName"],
          arrival_city_name: flight["destinationCity"],
          departure_gate_scheduled_at: convert_date(flight["filed_departuretime"]),
          departure_gate_actual_at: convert_date(flight["actualdeparturetime"]),
          arrival_gate_scheduled_at: convert_date(flight["estimatedarrivaltime"]),
          arrival_gate_actual_at: convert_date(flight["actualarrivaltime"])
        }
      end

      def self.trim_vendor_id(vendor_id)
        vendor_id.sub(/:\d*/, '') # Remove any digets after the colon ie AAL983-1533014744-airline-0259:2
      end

      def self.associate_and_save(record, aircraft)
        record.aircraft = aircraft
        record.airline = aircraft.airline
        record.departure_airport = find_airport(record[:departure_airport_code])
        record.arrival_airport = find_airport(record[:arrival_airport_code])
        record.save!
      end

      def self.convert_date(response_integer)
        response_integer > 0 ? Time.at(response_integer).utc : nil
      end

      def self.find_airport(icao_code)
        Airport.find_by(icao_code: icao_code)
      end
  end
end
