module Flight::InformActivity
  extend ActiveSupport::Concern

  included do
    (after_create_commit :create_activity, if: :can_be_created?) || (after_update :create_activity, if: :can_be_created?)
  end

  def create_activity
    Activity.create aircraft: self.aircraft, flight: self, station: @station
  end

  private

    def can_be_created?
      flying_to_maintenance_location? && is_enroute?
    end

    def flying_to_maintenance_location?
      @station = Station.find_by airport: destination_airport
      @station.present? ? true : false
    end

    def is_enroute?
      self.enroute?
    end

end
