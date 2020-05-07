class Configuration < ActiveRecord::Migration[5.1]
  def change
    # Rename
    rename_column :configuration, :configuration_id, :id

    rename_column :configuration, :configuration_name, :name
    rename_column :configuration, :configuration_description, :description
    rename_column :configuration, :configuration_type, :install_type
    rename_column :configuration, :configuration_file_path, :lopa_path
    rename_column :configuration, :configuration_fc, :first_class_seat_count
    rename_column :configuration, :configuration_bc, :business_class_seat_count
    rename_column :configuration, :configuration_pc, :premium_class_seat_count
    rename_column :configuration, :configuration_yc, :economy_class_seat_count
    rename_column :configuration, :configuration_actype_aircrafttype_id, :aircraft_type_id
    rename_column :configuration, :configuration_ife_ife_id, :ife_type_id
    rename_column :configuration, :configuration_airline_airline_id, :airline_id

    # Remove
    remove_column :configuration, :configuration_tag

    # Timestamps
    model_name = "configuration"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :configuration, :configurations
  end
end
