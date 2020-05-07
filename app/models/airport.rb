class Airport < ApplicationRecord
  include Searchable

  has_one :station
  has_one :program

  validates :name, :iata_code, :icao_code, :timezone, presence: true
  validates_uniqueness_of :name, case_sensitive: false
  validates_uniqueness_of :iata_code, case_sensitive: false
  validates_uniqueness_of :icao_code, case_sensitive: false

  def searchable_attributes
    [iata_code, icao_code, name, country, city]
  end

  def self.ordered_by_iata_code
    order(iata_code: :asc)
  end

end
