class Removal < ActiveRecord::Migration[5.1]
  def change
    # Rename
    rename_column :removal, :removal_id, :id

    rename_column :removal, :removal_location, :on_wing_position
    rename_column :removal, :removal_on_stock_item_id, :installed_stock_item_id
    rename_column :removal, :removal_off_stock_item_id, :removed_stock_item_id
    rename_column :removal, :removal_removalreason_removalreason_id, :removal_reason_id

    # Remove
    remove_foreign_key :removal, name: "fk_removal_removal_aircraft_55"
    remove_foreign_key :removal, name: "fk_removal_airport_111"

    remove_column :removal, :removal_aircraft_aircraft_id
    remove_column :removal, :removal_airport_airport_id
    # remove_column :removal, :removal_status
    remove_column :removal, :removal_turnin

    # Timestamps
    model_name = "removal"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :removal, :transactions
  end
end
