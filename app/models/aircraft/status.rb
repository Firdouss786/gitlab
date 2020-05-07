class Aircraft::Status < ApplicationRecord
  include Filterable

  has_many :flights, foreign_key: 'aircraft_status_id'
  belongs_to :current_flight, class_name: 'Flight', foreign_key: 'current_flight_id', optional: true
  belongs_to :aircraft

  enum state: { in_flight: "in_flight", arrived: "arrived" }

  def next_flight
  	current_flight.next_flight
  end
end
