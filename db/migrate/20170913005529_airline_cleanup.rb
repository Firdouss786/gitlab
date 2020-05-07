class AirlineCleanup < ActiveRecord::Migration[5.1]
  def change
    # Rename
    rename_column :airline, :airline_id, :id

    rename_column :airline, :airline_iatacode, :iata_code
    rename_column :airline, :airline_icaocode, :icao_code
    rename_column :airline, :airline_name, :name
    rename_column :airline, :airline_alias, :alias
    rename_column :airline, :airline_callsign, :callsign
    rename_column :airline, :airline_country, :country
    rename_column :airline, :airline_customer, :customer
    rename_column :airline, :airline_description, :description

    # Remove
    remove_column :airline, :airline_tailprocessing
    remove_column :airline, :oooi

    # Timestamps
    model_name = "airline"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :airline, :airlines
  end
end
