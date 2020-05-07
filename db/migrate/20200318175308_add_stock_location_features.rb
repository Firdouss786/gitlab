class AddStockLocationFeatures < ActiveRecord::Migration[6.0]
  def change
    add_column :stock_locations, :may_supply_to_aircraft, :boolean
    add_column :stock_locations, :may_retrieve_from_aircraft, :boolean
    add_column :stock_locations, :may_repair_on_site, :boolean
    add_column :stock_locations, :may_exclude_from_global_pool, :boolean
    add_column :stock_locations, :may_scrap, :boolean
  end
end
