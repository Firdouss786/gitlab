class SoftwarePlatform < ApplicationRecord
  validates :name, presence: true

  include Searchable

  def searchable_attributes
    [name, description]
  end
end
