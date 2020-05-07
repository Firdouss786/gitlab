class SubscribeAircraftJob < ApplicationJob
  queue_as :default

  def perform(aircraft_id)
    aircraft = Aircraft.find(aircraft_id)

    aircraft.subscribe_flights
  end
end
