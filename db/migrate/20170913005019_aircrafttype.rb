class Aircrafttype < ActiveRecord::Migration[5.1]
  def change
    # Rename
    rename_column :aircrafttype, :aircrafttype_id, :id

    rename_column :aircrafttype, :aircrafttype_name, :name
    rename_column :aircrafttype, :aircrafttype_description, :description
    rename_column :aircrafttype, :aircrafttype_oem_oem_id, :oem_id

    # Timestamps
    model_name = "aircrafttype"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :aircrafttype, :aircraft_types
  end
end
