module AlexaIntent
  extend ActiveSupport::Concern

  included do

    # might be "Heathrow" or "London Heathrow" or "London" – how to query for this?
    def self.parse_airport(slot)
      slot_value = slot["value"]

      if slot_value.length == 3 # an IATA code has been given
        response = Airport.find_by iata_code: slot_value
      else
        response = Airport.find_by name: slot_value
      end

      puts "Identified airport as #{response.inspect}"
      response
    end

  end
end
