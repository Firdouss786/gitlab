class RemoveCompositKeyFromActionsUser < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :task_actions_users, name: "fk_taskexecutionitem_user_user_02"
    remove_foreign_key :task_actions_users, name: "fk_taskexecutionitem_user_taskexecutionitem_01"

    rename_table :task_actions_users, :task_actions_users_old
  end
end
