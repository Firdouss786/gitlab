class CleanTaskActionsUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :task_actions_users, :taskcard_action_id, :task_action_id
  end
end
