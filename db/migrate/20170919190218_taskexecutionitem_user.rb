class TaskexecutionitemUser < ActiveRecord::Migration[5.1]
  def change
    # Join Table - taskcards has and belongs to many users

    rename_column :taskexecutionitem_user, :taskexecutionitem_taskexecutionitem_id, :taskcard_action_id
    rename_column :taskexecutionitem_user, :user_user_id, :user_id

    # Tablename
    rename_table :taskexecutionitem_user, :taskcard_actions_users
  end
end
