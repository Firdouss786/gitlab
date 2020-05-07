class RelocateTransferDestinations < ActiveRecord::Migration[5.1]
  def up

    # Move LINE (from) transfers
    execute <<-SQL
      UPDATE transfers
      JOIN stock_locations as outer_location
      ON outer_location.id = transfers.destination_stock_location_id
      SET transfers.destination_stock_location_id = (
        SELECT id FROM stock_locations
        WHERE stock_locations.name = outer_location.name
        AND stock_locations.category = "LINE"
        AND stock_locations.state = "SERVICEABLE"
      )
      WHERE transfers.to_state IN ("SERVICEABLE", "UNSERVICEABLE", "QUARANTINE", "STAC", "INSPECT", "SCRAP", "CREATION", "INTRANSIT")
      AND outer_location.category = "LINE"
    SQL

    # Move DIST (from) transfers
    execute <<-SQL
      UPDATE transfers
      JOIN stock_locations as outer_location
      ON outer_location.id = transfers.destination_stock_location_id
      SET transfers.destination_stock_location_id = (
        SELECT id FROM stock_locations
        WHERE stock_locations.name = outer_location.name
        AND stock_locations.category = "DIST"
        AND stock_locations.state = "SERVICEABLE"
      )
      WHERE transfers.to_state IN ("SERVICEABLE", "UNSERVICEABLE", "QUARANTINE", "STAC", "SCRAP", "CREATION", "INTRANSIT", "INSPECT")
      AND outer_location.category = "DIST"
    SQL

    # Move REPAIR (from) transfers
    execute <<-SQL
      UPDATE transfers
      JOIN stock_locations as outer_location
      ON outer_location.id = transfers.destination_stock_location_id
      SET transfers.destination_stock_location_id = (
        SELECT id FROM stock_locations
        WHERE stock_locations.name = outer_location.name
        AND stock_locations.category = "REPAIR"
        AND stock_locations.state = "REPAIR"
      )
      WHERE transfers.to_state IN ("SCRAP", "REPAIR", "CREATION")
      AND outer_location.category = "REPAIR"
    SQL

    # Move ENGINEERING (from) transfers
    execute <<-SQL
      UPDATE transfers
      JOIN stock_locations as outer_location
      ON outer_location.id = transfers.destination_stock_location_id
      SET transfers.destination_stock_location_id = (
        SELECT id FROM stock_locations
        WHERE stock_locations.name = outer_location.name
        AND stock_locations.category = "ENGINEERING"
        AND stock_locations.state = "INSPECT"
      )
      WHERE transfers.to_state IN ("INSPECT", "SCRAP", "CREATION", "INTRANSIT")
      AND outer_location.category = "ENGINEERING"
    SQL

    # Move any remaining transfers which are INTRANSIT
    execute <<-SQL
      UPDATE transfers
      SET transfers.destination_stock_location_id = transfers.source_stock_location_id
      WHERE transfers.destination_stock_location_id = 1
    SQL

  end

  def down
    "Rollback"
  end
end
