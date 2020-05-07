class RenameStockItemStates < ActiveRecord::Migration[5.1]
  def change
    execute <<-SQL
      UPDATE stock_items
      SET state = "installed"
      WHERE state = "AIRCRAFT"
    SQL

    execute <<-SQL
      UPDATE stock_items
      SET state = "serviceable"
      WHERE state = "SERVICEABLE"
    SQL

    execute <<-SQL
      UPDATE stock_items
      SET state = "repaired"
      WHERE state = "REPAIR"
    SQL

    execute <<-SQL
      UPDATE stock_items
      SET state = "quarantined"
      WHERE state = "QUARANTINE"
    SQL

    execute <<-SQL
      UPDATE stock_items
      SET state = "unserviceable"
      WHERE state = "UNSERVICEABLE"
    SQL

    execute <<-SQL
      UPDATE stock_items
      SET state = "inspecting"
      WHERE state = "INSPECT"
    SQL

    execute <<-SQL
      UPDATE stock_items
      SET state = "transiting"
      WHERE state = "INTRANSIT"
    SQL

    execute <<-SQL
      UPDATE stock_items
      SET state = "scrapped"
      WHERE state = "SCRAP"
    SQL

    execute <<-SQL
      UPDATE stock_items
      SET state = "removed"
      WHERE state = "STAC"
    SQL

    # Quarantine all 'Customer' parts
    execute <<-SQL
      UPDATE stock_items
      SET state = "quarantined"
      WHERE state = "CUSTOMER"
    SQL

    execute <<-SQL
      UPDATE stock_items
      SET state = "quarantined"
      WHERE state is NULL
    SQL
  end
end
