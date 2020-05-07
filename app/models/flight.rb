class Flight < ApplicationRecord
  include Flight::InformActivity

  after_update :touch_activity

  # belongs_to :aircraft_status, class_name: 'Aircraft::Status', optional: true
  belongs_to :aircraft
  belongs_to :airline
  has_one :activity, dependent: :nullify

  belongs_to :origin_airport, class_name: 'Airport', foreign_key: 'origin_airport_id', optional: true
  belongs_to :destination_airport, class_name: 'Airport', foreign_key: 'destination_airport_id', optional: true

  validates_uniqueness_of :vendor_id, case_sensitive: false

  scope :chronological, -> { order(arrival_gate_scheduled_at: :asc) }
  scope :arrived, -> { where.not(actual_arrival_time: nil) }
  scope :at_acceptable_airports, -> { where(destination_airport: Current.user.stations.map { |s| s.airport }) }

  scope :enroute, -> { select { |flight| flight.enroute? } }
  scope :arrived, -> { select { |flight| flight.arrived? } }
  scope :scheduled, -> { select { |flight| flight.scheduled? } }

  before_create :associated_airports


  def departed?
    actual_departure_time?
  end

  def arrived? 
    actual_arrival_time?
  end

  def enroute? 
    departed? && !arrived?
  end

  def scheduled?
    !departed?
  end

  def status
    return :arrived if arrived?
    return :enroute if enroute?
    return :scheduled if scheduled?
  end


  def flight_time_remaining
    TimeDifference.between(Time.now, runway_arrival).in_general
  end

  def ground_time
    TimeDifference.between(estimated_arrival_time, self.next_flight.filed_departure_time).in_general
  end

  def next_flight
    Flight.where(aircraft: self.aircraft)
          .where("filed_departure_time > ?", self.filed_departure_time)
          .order(:filed_departure_time)
          .limit(1).first
  end

  private

    def associated_airports
      self.origin_airport = Airport.find_by(icao_code: origin_airport_code)
      self.destination_airport = Airport.find_by(icao_code: destination_airport_code)
    end

    def touch_activity
      activity.touch if activity.present?
    end

end
