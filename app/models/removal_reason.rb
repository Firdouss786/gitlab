class RemovalReason < ApplicationRecord
  belongs_to :product_category

  scope :for_product, -> (product) { where(product_category: product.product_category) }
  scope :order_by_name, -> { order("name ASC") }
end
