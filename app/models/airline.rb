class Airline < ApplicationRecord

  include Accessible, Searchable

  validates :iata_code, :icao_code, :name, :country, presence: true

  has_one_attached :logo

  has_one :program

  has_many :task_templates
  has_many :fleets
  has_many :aircrafts
  has_many :flights
  has_many :faults, through: :aircrafts
  has_many :tasks, through: :aircrafts
  has_many :aircraft_statuses, through: :aircrafts

  has_many :airline_accesses
  has_many :users, through: :airline_accesses

  has_many :flight_subscriptions, through: :aircrafts

  def self.customers
    where(customer: true)
  end

  def accessible_resource_name
    name
  end

  def searchable_attributes
    [iata_code, icao_code, name, callsign, country, description]
  end

  def accessible_approvers
    # TODO: Update once we get the station managers thing in place
    [User.find_by(email: "albert@thalesinflight.com")]
  end

  def ordered_aircrafts_by_tail
    self.aircrafts.order(tail: :asc)
  end

  def self.ordered_by_icao_code
    order(icao_code: :asc)
  end

  def self.get_aircrafts
    includes(:aircrafts).flat_map { |a| a.aircrafts }
  end

end
