class DropUnusedStockLocations < ActiveRecord::Migration[5.1]
  def change
    # Delete unused stock locations from the 4 main stock location categories (LINE, DIST, REPAIR, ENGINEERING)
    # The unused stock locations have been moved to the 'state' of the stock item itself

    # Script to check if there are any transfers still associated with the stock locations
    # which need to be deleted:
    # SELECT * FROM transfers
    # JOIN stock_locations
    # ON stock_locations.id = transfers.source_stock_location_id
    # WHERE stock_locations.state IN ("UNSERVICEABLE", "QUARANTINE", "STAC", "INSPECT", "SCRAP")
    # AND stock_locations.category IN ("LINE", "DIST")

    # LINE and DIST stocks
    execute <<-SQL
      DELETE FROM stock_locations
      WHERE stock_locations.state IN ("UNSERVICEABLE", "QUARANTINE", "STAC", "INSPECT", "SCRAP")
      AND stock_locations.category IN ("LINE", "DIST")
    SQL

    # ENGINEERING stocks
    execute <<-SQL
      DELETE FROM stock_locations
      WHERE stock_locations.state IN ("SCRAP")
      AND stock_locations.category = ("ENGINEERING")
    SQL

    # REPAIR stocks
    execute <<-SQL
      DELETE FROM stock_locations
      WHERE stock_locations.state IN ("SCRAP")
      AND stock_locations.category = ("REPAIR")
    SQL

    # INTRANSIT stock
    # execute <<-SQL
    #   DELETE FROM stock_locations
    #   WHERE stock_locations.state = ("INTRANSIT")
    #   AND stock_locations.category = ("INTRANSIT")
    # SQL

    # REPAIR stocks only have 1 type, so nothing to drop
  end
end
