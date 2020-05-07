class Intents::NextFlight
  include AlexaIntent

  def self.handle(slots)
    @slots = slots

    unless airport_given? && identify_airport
      return "I was unable to find this airport, try using the I.A.T.A code instead"
    end

    flights = @airport.arrival_flights.in_air.chronological.limit(1)

    if flights.any?
      "The next flight will be #{flights.first.aircraft.registration}"
    else
      "I can't find any flights inbound to #{@airport.name}"
    end

  end

  private

    def self.airport_given?
      @slots["airport"] && @slots["airport"]["value"]
    end

    def self.identify_airport
      @airport = parse_airport(@slots["airport"])
    end
end
