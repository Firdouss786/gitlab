class ChangeStockLocationParentName < ActiveRecord::Migration[5.1]
  def change
    rename_column :stock_locations, :station_id, :parent_id
    add_column :stock_locations, :parent_type, :string
    add_index :stock_locations, :parent_type

    execute <<-SQL
      UPDATE stock_locations
      SET parent_type = "Aircraft"
      WHERE category = "Aircraft"
    SQL

    execute <<-SQL
      UPDATE stock_locations
      SET parent_type = "Station"
      WHERE category != "Aircraft"
    SQL

    execute <<-SQL
      UPDATE stock_locations
      SET category = NULL
      WHERE parent_type = "Aircraft"
    SQL
  end
end
