class AirportCleanup < ActiveRecord::Migration[5.1]
  def change
    # Rename
    rename_column :airport, :airport_id, :id

    rename_column :airport, :airport_iatacode, :iata_code
    rename_column :airport, :airport_icaocode, :icao_code
    rename_column :airport, :airport_name, :name
    rename_column :airport, :airport_country, :country
    rename_column :airport, :airport_city, :city
    rename_column :airport, :airport_latitude, :latitude
    rename_column :airport, :airport_longitude, :longitude
    rename_column :airport, :airport_dst, :dst
    rename_column :airport, :airport_timezone, :timezone

    # Remove
    remove_column :airport, :airport_countrycode
    remove_column :airport, :airport_region

    # Timestamps
    model_name = "airport"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :airport, :airports
  end
end
