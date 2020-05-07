class StockLocation < ApplicationRecord
  validates :name, :parent_type, presence: true
  validates :category, presence: true, if: :is_station?

  belongs_to :parent, polymorphic: true
  has_many :stock_items

  def is_station?
    self.parent_type == "Station"
  end

end
