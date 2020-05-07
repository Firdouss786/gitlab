class ProductAllotment < ApplicationRecord
  validates :quantity, presence: true

  belongs_to :product, touch: true
  belongs_to :fleet, touch: true

end
