class AircraftType < ApplicationRecord
  validates :name, presence: true

  belongs_to :manufacturer

  has_one :fleet
end
