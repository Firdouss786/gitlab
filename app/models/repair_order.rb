class RepairOrder < ApplicationRecord
  belongs_to :user
  belongs_to :origin_stock_location, class_name: "StockLocation"
  belongs_to :destination_stock_location, class_name: "StockLocation"
end
