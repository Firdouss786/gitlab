json.extract! airline, :id, :iata_code, :icao_code, :name, :alias, :callsign, :country, :customer, :description, :created_at, :updated_at
json.url airline_url(airline, format: :json)
