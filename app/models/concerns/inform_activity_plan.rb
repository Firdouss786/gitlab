module InformActivityPlan
  extend ActiveSupport::Concern

  included do
    after_create :create_activity_plan
    after_update :update_activity_plan
  end

  private

    def create_activity_plan
      station = self.destination_airport.try(:station)
      arrival_time = self.runway_arrival
      ActivityPlan.create(aircraft: self.aircraft, flight: self, station: station, original_arrival_time: arrival_time, state: "created") if station && arrival_time
    end

    def update_activity_plan
      policy_result = ActivityPlanUpdatePolicy.new(flight: self).perform
      if policy_result
        destroy_activity_plan
        create_activity_plan
      end
    end

    def destroy_activity_plan
      aircraft = Aircraft.find_by_id(self.previous_changes[:aircraft_id].try(:first)) || self.aircraft
      destination_airport = Airport.find_by_id(self.previous_changes[:destination_airport_id].try(:first)) || self.destination_airport
      activity_plan = ActivityPlan.where(aircraft: aircraft, flight: self, station: destination_airport.station, state: "created").first
      activity_plan.destroy if activity_plan
    end

end
