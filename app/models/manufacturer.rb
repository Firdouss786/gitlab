class Manufacturer < ApplicationRecord
  include Searchable

  validates :name, presence: true, uniqueness: {case_sensitive: false}
  has_many :aircraft_types

  def searchable_attributes
    [name, description]
  end

end
