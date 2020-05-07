json.extract! fleet, :id, :name, :description, :install_type, :lopa_path, :aircraft_type, :software_platform, :airline, :created_at, :updated_at
json.url fleet_url(fleet, format: :json)
