class UnsubscribeAircraftJob < ApplicationJob
  queue_as :default

  def perform(aircraft_id)
    aircraft = Aircraft.find(aircraft_id)

    aircraft.unsubscribe_flights
  end
end
