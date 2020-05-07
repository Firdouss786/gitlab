class MoveStockItems < ActiveRecord::Migration[5.1]
  def change

    # Move IN-TRANSIT stock items back to their source stock
    execute <<-SQL
      UPDATE stock_items
      JOIN transfers
      ON stock_items.lastest_transfer_id = transfers.id
      SET stock_items.stock_location_id = transfers.source_stock_location_id
      WHERE stock_items.state = "INTRANSIT"
    SQL

    # Move LINE stock items to "SERVICEABLE" stock (which will become the primary stock location)
    execute <<-SQL
      UPDATE stock_items
      JOIN stock_locations as outer_location
      ON outer_location.id = stock_items.stock_location_id
      SET stock_items.stock_location_id = (
      	SELECT id FROM stock_locations
      	WHERE stock_locations.name = outer_location.name
      	AND stock_locations.category = "LINE"
      	AND stock_locations.state = "SERVICEABLE"
      )
      WHERE outer_location.state IN ("SERVICEABLE", "UNSERVICEABLE", "QUARANTINE", "STAC", "INSPECT", "SCRAP", "INTRANSIT")
      AND outer_location.category = "LINE"
    SQL

    # Move DIST stock items to "SERVICEABLE" stock (which will become the primary stock location)
    execute <<-SQL
      UPDATE stock_items
      JOIN stock_locations as outer_location
      ON outer_location.id = stock_items.stock_location_id
      SET stock_items.stock_location_id = (
        SELECT id FROM stock_locations
        WHERE stock_locations.name = outer_location.name
        AND stock_locations.category = "DIST"
        AND stock_locations.state = "SERVICEABLE"
      )
      WHERE outer_location.state IN ("SERVICEABLE", "UNSERVICEABLE", "QUARANTINE", "STAC", "SCRAP", "INSPECT")
      AND outer_location.category = "DIST"
    SQL

    # Move REPAIR stock items to "REPAIR" stock (which will become the primary stock location)
    execute <<-SQL
      UPDATE stock_items
      JOIN stock_locations as outer_location
      ON outer_location.id = stock_items.stock_location_id
      SET stock_items.stock_location_id = (
      	SELECT id FROM stock_locations
      	WHERE stock_locations.name = outer_location.name
      	AND stock_locations.category = "REPAIR"
      	AND stock_locations.state = "REPAIR"
      )
      WHERE outer_location.state IN ("SCRAP", "REPAIR")
      AND outer_location.category = "REPAIR"
    SQL

    # Move ENGINERING stock items to "INSPECT" stock (which will become the primary stock location)
    execute <<-SQL
      UPDATE stock_items
      JOIN stock_locations as outer_location
      ON outer_location.id = stock_items.stock_location_id
      SET stock_items.stock_location_id = (
      	SELECT id FROM stock_locations
      	WHERE stock_locations.name = outer_location.name
      	AND stock_locations.category = "ENGINEERING"
      	AND stock_locations.state = "INSPECT"
      )
      WHERE outer_location.state IN ("INSPECT", "SCRAP")
      AND outer_location.category = "ENGINEERING"
    SQL

  end
end
