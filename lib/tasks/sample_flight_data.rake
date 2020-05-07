namespace :flight do
  desc "Seeds the database with some sample flight data"
  task seed: :environment do

    # Delete pre-existing data
    Aircraft.find_by(registration: "G-STBA").flights.delete_all
    Aircraft.find_by(registration: "G-STBB").flights.delete_all
    
    flight1 = Flight.create(
      vendor_id: "BAW184-1527053126-airline-0143",
      flight_number: "BAW184",
      aircraft_type: "B772",
      tail_number: "gstba",
      origin_airport_code: "KEWR",
      origin_airport_name: "Newark Liberty Intl",
      origin_city_name: "Newark, NJ",
      destination_airport_code: "EGLL",
      destination_airport_name: "London Heathrow",
      destination_city_name: "London, England",
      aircraft: Aircraft.find_by(registration: "G-STBA"),
      airline: Aircraft.find_by(registration: "G-STBA").airline,
      origin_airport: Airport.find_by(iata_code: "JFK"),
      destination_airport: Airport.find_by(iata_code: "LHR"),
      filed_departure_time: DateTime.now - 8.hours,
      actual_departure_time: DateTime.now - 8.hours,
      filed_blockout_time: DateTime.now - 8.hours,
      estimated_blockout_time: DateTime.now - 8.hours,
      actual_blockout_time: DateTime.now - 8.hours,
      filed_arrival_time: DateTime.now + 8.hours,
      estimated_arrival_time: DateTime.now + 8.hours,
      actual_arrival_time: nil,
      filed_blockin_time: DateTime.now + 8.5.hours,
      estimated_blockin_time: DateTime.now + 8.5.hours,
      actual_blockin_time: nil
    )

    # flight1.aircraft.flight_subscription.deregister_with_flight_service

    flight2 = Flight.create(
      vendor_id: "BAW184-1527053126-airline-0143",
      flight_number: "BAW184",
      aircraft_type: "B772",
      tail_number: "gstbb",
      origin_airport_code: "KEWR",
      origin_airport_name: "Newark Liberty Intl",
      origin_city_name: "Newark, NJ",
      destination_airport_code: "EGLL",
      destination_airport_name: "London Heathrow",
      destination_city_name: "London, England",
      aircraft: Aircraft.find_by(registration: "G-STBB"),
      airline: Aircraft.find_by(registration: "G-STBB").airline,
      origin_airport: Airport.find_by(iata_code: "JFK"),
      destination_airport: Airport.find_by(iata_code: "LHR"),
      filed_departure_time: DateTime.now - 8.hours,
      actual_departure_time: DateTime.now - 8.hours,
      filed_blockout_time: DateTime.now - 8.hours,
      estimated_blockout_time: DateTime.now - 8.hours,
      actual_blockout_time: DateTime.now - 8.hours,
      filed_arrival_time: DateTime.now - 10.minutes,
      estimated_arrival_time: DateTime.now - 10.minutes,
      actual_arrival_time: DateTime.now - 10.minutes,
      filed_blockin_time: DateTime.now - 10.minutes,
      estimated_blockin_time: DateTime.now - 10.minutes,
      actual_blockin_time: DateTime.now - 10.minutes
    )

    # flight2.aircraft.flight_subscription.deregister_with_flight_service
  end
end
