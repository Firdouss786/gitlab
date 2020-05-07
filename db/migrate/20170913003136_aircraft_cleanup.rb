class AircraftCleanup < ActiveRecord::Migration[5.1]
  def change
    rename_column :aircraft, :aircraft_id, :id

    rename_column :aircraft, :aircraft_tail, :tail
    rename_column :aircraft, :aircraft_msn, :msn
    rename_column :aircraft, :aircraft_fin, :fin
    rename_column :aircraft, :aircraft_registration, :registration
    rename_column :aircraft, :aircraft_eis, :eis
    rename_column :aircraft, :aircraft_tot, :tot
    rename_column :aircraft, :aircraft_description, :description
    rename_column :aircraft, :aircraft_locked, :locked
    rename_column :aircraft, :aircraft_enable, :active
    rename_column :aircraft, :aircraft_configuration_configuration_id, :configuration_id
    rename_column :aircraft, :aircraft_airline_airline_id, :airline_id

    # Remove
    remove_column :aircraft, :aircraft_tailnumber

    # Timestamps
    model_name = "aircraft"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at
  end
end
