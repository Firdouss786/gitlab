json.extract! stock_item, :id, :product_id, :serial_number, :model_numbers, :revision, :batch_number, :category, :quantity, :lastest_transfer_id, :stock_location_id, :shelf_life_expiration, :shelved_at, :user_id, :state, :created_at, :updated_at
json.url stock_item_url(stock_item, format: :json)
