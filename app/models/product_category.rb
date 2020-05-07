class ProductCategory < ApplicationRecord

  include Searchable

  validates :name, :product_type, presence: true
  validates_uniqueness_of :name, case_sensitive: false

  enum product_type: { CONSUMABLE: "CONSUMABLE", ROTABLE: "ROTABLE" }

  def searchable_attributes
    [name, description, product_type]
  end

end
