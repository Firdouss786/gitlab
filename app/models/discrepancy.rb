class Discrepancy < ApplicationRecord

  include Searchable, Archivable
  
  def searchable_attributes
    [name]
  end

  belongs_to :discrepancy_category

  validates :name, presence: true
  validates_uniqueness_of :name, case_sensitive: false, scope: :discrepancy_category_id

end
