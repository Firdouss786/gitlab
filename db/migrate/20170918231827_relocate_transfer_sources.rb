class RelocateTransferSources < ActiveRecord::Migration[5.1]
  def up

    # If the source is INTRANSIT, set it to the destination (probably Servo bug)
    execute <<-SQL
      UPDATE transfers
      SET transfers.source_stock_location_id = transfers.destination_stock_location_id
      WHERE transfers.source_stock_location_id = 1
    SQL

    # Move LINE (from) transfers
    execute <<-SQL
      UPDATE transfers
      JOIN stock_locations as outer_location
      ON outer_location.id = transfers.source_stock_location_id
      SET transfers.source_stock_location_id = (
        SELECT id FROM stock_locations
        WHERE stock_locations.name = outer_location.name
        AND stock_locations.category = "LINE"
        AND stock_locations.state = "SERVICEABLE"
      )
      WHERE transfers.from_state IN ("SERVICEABLE", "UNSERVICEABLE", "QUARANTINE", "STAC", "INSPECT", "SCRAP", "CREATION", "INTRANSIT")
      AND outer_location.category = "LINE"
    SQL

    # Move DIST (from) transfers
    execute <<-SQL
      UPDATE transfers
      JOIN stock_locations as outer_location
      ON outer_location.id = transfers.source_stock_location_id
      SET transfers.source_stock_location_id = (
        SELECT id FROM stock_locations
        WHERE stock_locations.name = outer_location.name
        AND stock_locations.category = "DIST"
        AND stock_locations.state = "SERVICEABLE"
      )
      WHERE transfers.from_state IN ("SERVICEABLE", "UNSERVICEABLE", "QUARANTINE", "STAC", "SCRAP", "CREATION", "INTRANSIT", "INSPECT")
      AND outer_location.category = "DIST"
    SQL

    # Move REPAIR (from) transfers
    execute <<-SQL
      UPDATE transfers
      JOIN stock_locations as outer_location
      ON outer_location.id = transfers.source_stock_location_id
      SET transfers.source_stock_location_id = (
        SELECT id FROM stock_locations
        WHERE stock_locations.name = outer_location.name
        AND stock_locations.category = "REPAIR"
        AND stock_locations.state = "REPAIR"
      )
      WHERE transfers.from_state IN ("SCRAP", "REPAIR", "CREATION", "INTRANSIT")
      AND outer_location.category = "REPAIR"
    SQL

    # Move ENGINEERING (from) transfers
    execute <<-SQL
      UPDATE transfers
      JOIN stock_locations as outer_location
      ON outer_location.id = transfers.source_stock_location_id
      SET transfers.source_stock_location_id = (
        SELECT id FROM stock_locations
        WHERE stock_locations.name = outer_location.name
        AND stock_locations.category = "ENGINEERING"
        AND stock_locations.state = "INSPECT"
      )
      WHERE transfers.from_state IN ("INSPECT", "SCRAP", "CREATION", "INTRANSIT")
      AND outer_location.category = "ENGINEERING"
    SQL

  end

  def down
    "Rollback"
  end
end
