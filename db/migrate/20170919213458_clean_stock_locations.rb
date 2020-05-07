class CleanStockLocations < ActiveRecord::Migration[5.1]
  def change
    # Remove the state column from stock_locations as it's no longer needed
    remove_column :stock_locations, :state

    # Associate and rename the orphaned ACA stock location
    execute <<-SQL
      UPDATE stock_locations
      SET station_id = 190,
      category = "LINE"
      WHERE name = "ACA"
    SQL

    # Give stations a name as they *could* live independently of airports
    add_column :stations, :name, :string

    execute <<-SQL
      UPDATE stations
      JOIN airports
      ON airports.id = stations.airport_id
      SET stations.name = airports.iata_code
    SQL
    
  end
end
