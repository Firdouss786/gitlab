class ActivityPlanUpdatePolicy
  include ActiveModel::Model

  attr_accessor :flight

  validates_presence_of :flight

  def perform
    aircraft_updated? || destination_airport_updated? || arrival_time_exceeds_limit?
  end

  private

    def aircraft_updated?
      flight.previous_changes.values_at(:aircraft_id).present?
    end

    def destination_airport_updated?
      flight.previous_changes.values_at(:destination_airport_id).present?
    end

    def arrival_time_exceeds_limit?
      !flight.runway_arrival.between?(original_arrival_time - 6.hours, original_arrival_time + 6.hours)
    end

end
