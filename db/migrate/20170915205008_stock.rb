class Stock < ActiveRecord::Migration[5.1]
  def change
    # Rename
    rename_column :stock, :stock_id, :id

    rename_column :stock, :stock_name, :name
    rename_column :stock, :stock_type, :state
    rename_column :stock, :stock_locationtype, :category

    # This was the station_id anyway, jus named different
    rename_column :stock, :stock_parent, :station_id

    # Remove airport association as we will use station instead
    remove_foreign_key :stock, name: "fk_stock_stock_location_74"
    remove_column :stock, :stock_location_airport_id

    # Timestamps
    model_name = "stock"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :stock, :stock_locations
  end
end
