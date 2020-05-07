class Correctiveaction < ActiveRecord::Migration[5.1]
  def change
    # Remove triggers
    execute <<-SQL
      DROP TRIGGER correctiveaction_audit_insert
    SQL

    execute <<-SQL
      DROP TRIGGER correctiveaction_audit_update
    SQL

    execute <<-SQL
      DROP TRIGGER correctiveaction_audit_delete
    SQL

    # Rename
		rename_column :correctiveaction, :correctiveaction_id, :id

		rename_column :correctiveaction, :correctiveaction_date, :job_started_at
		rename_column :correctiveaction, :correctiveaction_user_user_id, :user_id
		rename_column :correctiveaction, :correctiveaction_creator_user_id, :creator_id
		rename_column :correctiveaction, :correctiveaction_deferreason_deferreason_id, :defer_reason_id
		rename_column :correctiveaction, :correctiveaction_maintenanceaction_maintenanceaction_id, :maintenance_action_id
		rename_column :correctiveaction, :correctiveaction_comment, :logbook_text
		rename_column :correctiveaction, :correctiveaction_reference, :document_reference
		rename_column :correctiveaction, :correctiveaction_removal_removal_id, :replacement_id
		rename_column :correctiveaction, :correctiveaction_opdef, :opdef
		rename_column :correctiveaction, :correctiveaction_removalreason_removalreason_id, :removal_reason_id
		rename_column :correctiveaction, :correctiveaction_quantity, :batch_quantity
		rename_column :correctiveaction, :correctiveaction_activity_activity_id, :activity_id
		rename_column :correctiveaction, :correctiveaction_fault_fault_id, :fault_id
		rename_column :correctiveaction, :correctiveaction_product_productsubtype_id, :product_id
		rename_column :correctiveaction, :correctiveaction_batchnumber, :batch_number
		rename_column :correctiveaction, :correctiveaction_logbook, :logbook_reference
    rename_column :correctiveaction, :correctiveaction_deferclass, :mel_category

    # Remove
		remove_column :correctiveaction, :correctiveaction_consumptiondone
		remove_column :correctiveaction, :correctiveaction_freebee
		remove_column :correctiveaction, :correctiveaction_freebeereason
		remove_column :correctiveaction, :correctiveaction_opendate
		remove_column :correctiveaction, :correctiveaction_closedate

    # Timestamps
    model_name = "correctiveaction"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :correctiveaction, :corrective_actions
  end
end
