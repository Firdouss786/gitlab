class DeferReason < ApplicationRecord
  include Searchable

  validates_uniqueness_of :name, case_sensitive: false

  has_one :corrective_action

  def searchable_attributes
    [name, description]
  end
end
