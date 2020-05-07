json.extract! activity, :id, :started_at, :closed_at, :boarded_at, :unboarded_at, :created_by_id, :station_id, :is_open, :inbound_flight_number, :inbound_airport_id, :outbound_airport_id, :outbound_flight_number, :aircraft_id, :closed_by_id, :user_id, :created_at, :updated_at
json.url activity_url(activity, format: :json)
