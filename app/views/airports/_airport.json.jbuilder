json.extract! airport, :id, :iata_code, :icao_code, :name, :country, :city, :latitude, :longitude, :dst, :timezone, :created_at, :updated_at
json.url airport_url(airport, format: :json)
