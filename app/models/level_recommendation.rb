class LevelRecommendation < ApplicationRecord
  validates :product, :recommended_quantity, :stock_location, presence: true

  belongs_to :product
  belongs_to :stock_location
end
