class DiscrepancyCategory < ApplicationRecord

  include Searchable

  def searchable_attributes
    [category]
  end

  has_many :discrepancies

  validates :category, presence: true
  validates_uniqueness_of :category, case_sensitive: false

end
