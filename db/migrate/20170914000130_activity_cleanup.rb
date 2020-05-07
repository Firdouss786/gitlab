class ActivityCleanup < ActiveRecord::Migration[5.1]
  def change
    # Remove triggers
    execute <<-SQL
      DROP TRIGGER activity_audit_insert
    SQL

    execute <<-SQL
      DROP TRIGGER activity_audit_update
    SQL

    execute <<-SQL
      DROP TRIGGER activity_audit_delete
    SQL

    # Rename
    rename_column :activity, :activity_id, :id

    rename_column :activity, :activity_timestamp_start, :started_at
    rename_column :activity, :activity_timestamp_stop, :closed_at
    rename_column :activity, :activity_boarding, :boarded_at
    rename_column :activity, :activity_unboarding, :unboarded_at
    rename_column :activity, :activity_creator_user_id, :created_by_user_id
    rename_column :activity, :activity_location_airport_id, :airport_id
    rename_column :activity, :activity_status, :is_open
    rename_column :activity, :activity_inboundflightnumber, :inbound_flight_number
    rename_column :activity, :activity_inboundairport_airport_id, :inbound_airport_id
    rename_column :activity, :activity_outboundairport_airport_id, :outbound_airport_id
    rename_column :activity, :activity_outboundflightnumber, :outbound_flight_number
    rename_column :activity, :activity_aircraft_aircraft_id, :aircraft_id
    rename_column :activity, :activity_closer_user_id, :closed_by_user_id
    rename_column :activity, :activity_user_user_id, :user_id

    # Remove
    remove_column :activity, :activity_mcccreated
    remove_column :activity, :activity_consumptiondone

    # Timestamps
    model_name = "activity"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :activity, :activities
  end
end
