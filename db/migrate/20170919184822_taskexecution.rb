class Taskexecution < ActiveRecord::Migration[5.1]
  def change
    # Remove triggers
    execute <<-SQL
      DROP TRIGGER taskexecution_audit_insert
    SQL

    execute <<-SQL
      DROP TRIGGER taskexecution_audit_update
    SQL

    execute <<-SQL
      DROP TRIGGER taskexecution_audit_delete
    SQL

    # Rename
    rename_column :taskexecution, :taskexecution_id, :id

    rename_column :taskexecution, :taskexecution_creator_user_id, :created_by_user_id
    rename_column :taskexecution, :taskexecution_startdate, :started_at
    rename_column :taskexecution, :taskexecution_enddate, :completed_at
    rename_column :taskexecution, :taskexecution_comment, :logbook_text
    rename_column :taskexecution, :taskexecution_completion, :completion_percentage
    rename_column :taskexecution, :taskexecution_activitystart_activity_id, :started_in_activity_id
    rename_column :taskexecution, :taskexecution_activitystop_activity_id, :completed_in_activity_id
    rename_column :taskexecution, :taskexecution_taskcard_taskcard_id, :taskcard_template_id
    rename_column :taskexecution, :taskexecution_status, :state
    rename_column :taskexecution, :taskexecution_aircraft_aircraft_id, :aircraft_id
    rename_column :taskexecution, :taskexecution_reference, :logbook_reference
    rename_column :taskexecution, :taskexecution_user_user_id, :user_id

    # Timestamps
    model_name = "taskexecution"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :taskexecution, :taskcards
  end
end
