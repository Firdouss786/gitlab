class StockItemState < ActiveRecord::Migration[5.1]
  def change

    # Set the state of the stock_item to that of its stock location
    execute <<-SQL
      UPDATE stock_items
      JOIN stock_locations
      ON stock_locations.id = stock_items.stock_location_id
      SET stock_items.state = stock_locations.state
    SQL

  end
end
