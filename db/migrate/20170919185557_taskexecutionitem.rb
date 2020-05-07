class Taskexecutionitem < ActiveRecord::Migration[5.1]
  def change
    # Remove triggers
    execute <<-SQL
      DROP TRIGGER taskexecutionitem_audit_insert
    SQL

    execute <<-SQL
      DROP TRIGGER taskexecutionitem_audit_update
    SQL

    execute <<-SQL
      DROP TRIGGER taskexecutionitem_audit_delete
    SQL

    # Rename
    rename_column :taskexecutionitem, :taskexecutionitem_id, :id

    rename_column :taskexecutionitem, :taskexecutionitem_creator_user_id, :created_by_user_id
    rename_column :taskexecutionitem, :taskexecutionitem_date, :completed_at
    rename_column :taskexecutionitem, :taskexecutionitem_completion, :completion_percentage
    rename_column :taskexecutionitem, :taskexecutionitem_comment, :logbook_text
    rename_column :taskexecutionitem, :taskexecutionitem_log_activity_id, :activity_id
    rename_column :taskexecutionitem, :taskexecutionitem_taskexecution_taskexecution_id, :taskcard_id
    rename_column :taskexecutionitem, :taskexecutionitem_user_user_id, :user_id

    # Timestamps
    model_name = "taskexecutionitem"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :taskexecutionitem, :taskcard_actions
  end
end
