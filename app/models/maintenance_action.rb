class MaintenanceAction < ApplicationRecord

  include Searchable

  validates :name, uniqueness: { case_sensitive: false }, presence: true

  def searchable_attributes
    [name, description]
  end

end
