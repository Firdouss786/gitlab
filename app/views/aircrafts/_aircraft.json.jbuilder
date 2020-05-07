json.extract! aircraft, :id, :tail, :msn, :fin, :registration, :eis, :tot, :description, :locked, :active, :created_at, :updated_at

json.url aircraft_url(aircraft, format: :json)
