json.extract! transfer, :id, :state, :category, :comment, :airway_bill, :sent_by_id, :received_by_id, :stock_item_id, :source_stock_location_id, :destination_stock_location_id, :filename, :sent_at, :received_at, :created_by_id, :activity_id, :from_state, :to_state, :created_at, :updated_at
json.url transfer_url(transfer, format: :json)
