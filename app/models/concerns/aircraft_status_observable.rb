module AircraftStatusObservable
  extend ActiveSupport::Concern

  included do
    before_save :associate_flight_to_aircraft_status
    after_save :set_current_flight
  end

  private
    def associate_flight_to_aircraft_status
      # Create an Aircraft::Status if one doesn't already exist
      self.aircraft_status = Aircraft::Status.find_or_initialize_by(
        aircraft: self.aircraft
      )
    end

    def set_current_flight
      if in_flight?
        aircraft_status.update(state: "in_flight", current_flight: self)
      end

      if arrived?
        aircraft_status.update(state: "arrived", current_flight: self)
      end
    end

end
