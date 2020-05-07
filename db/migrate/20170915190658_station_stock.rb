class StationStock < ActiveRecord::Migration[5.1]
  def change
    # Remove FK's
    remove_foreign_key :station_stock, name: "fk_station_stock_station_01"
    remove_foreign_key :station_stock, name: "fk_station_stock_stock_02"

    # Drop Table
    drop_table :station_stock
  end
end
