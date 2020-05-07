json.extract! repair_order, :id, :user_id, :origin_stock_location_id, :destination_stock_location_id, :part_transaction_id, :created_at, :updated_at
json.url repair_order_url(repair_order, format: :json)
