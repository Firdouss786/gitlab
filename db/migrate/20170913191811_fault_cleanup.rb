class FaultCleanup < ActiveRecord::Migration[5.1]
  def change
    # Remove triggers
    execute <<-SQL
      DROP TRIGGER fault_audit_insert
    SQL

    execute <<-SQL
      DROP TRIGGER fault_audit_update
    SQL

    execute <<-SQL
      DROP TRIGGER fault_audit_delete
    SQL

    # Rename
    rename_column :fault, :fault_id, :id

    rename_column :fault, :fault_logbookpage, :logbook_reference
    rename_column :fault, :fault_discovered, :discovered
    rename_column :fault, :fault_discrepancy_discrepancy_id, :discrepancy_id
    rename_column :fault, :fault_user_user_id, :user_id
    rename_column :fault, :fault_creator_user_id, :raised_by_user_id
    rename_column :fault, :fault_resolution_correctiveaction_id, :corrective_action_id
    rename_column :fault, :fault_comment, :technician_comment
    rename_column :fault, :fault_action_carried, :action_carried
    rename_column :fault, :fault_description, :logbook_text
    rename_column :fault, :fault_flightnumber, :raised_on_flight
    rename_column :fault, :fault_confirmed, :confirmed
    rename_column :fault, :fault_inbounddeferred, :inbound_deferred
    rename_column :fault, :fault_cid, :cid
    rename_column :fault, :fault_attachment, :attachment_filename
    rename_column :fault, :fault_attachment_link, :attachment
    rename_column :fault, :fault_status, :state
    rename_column :fault, :fault_impact, :impacted_seat_count
    rename_column :fault, :fault_seats, :seats_impacted
    rename_column :fault, :fault_created, :raised_at
    rename_column :fault, :fault_deferralref, :deferral_reference
    rename_column :fault, :fault_mcccomment, :controller_comment
    rename_column :fault, :fault_aircraft_aircraft_id, :aircraft_id
    rename_column :fault, :fault_log_activity_id, :activity_id
    rename_column :fault, :fault_deferclass, :mel_cetegory
    rename_column :fault, :fault_mccnotification, :alert_raised
    rename_column :fault, :fault_fmr, :fmr
    rename_column :fault, :fault_pirep, :pirep
    rename_column :fault, :fault_mccstatus, :mcc_status
    rename_column :fault, :fault_closed, :resolved_at
    rename_column :fault, :fault_deferquantity, :defer_quantity
    rename_column :fault, :fault_mccdescription, :mcc_description
    rename_column :fault, :fault_lastaction_correctiveaction_id, :latest_corrective_action_id
    rename_column :fault, :fault_deferreason_deferreason_id, :defer_reason_id

    # Remove
    remove_foreign_key :fault, name: "fk_fault_fault_discrepancy_101"
    remove_column :fault, :fault_customermro
    remove_column :fault, :fault_mccpriority
    remove_column :fault, :fault_mccdiscrepancy_discrepancy_id

    # Timestamps
    model_name = "fault"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :fault, :faults
	end
end
