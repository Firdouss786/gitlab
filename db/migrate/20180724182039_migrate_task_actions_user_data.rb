class MigrateTaskActionsUserData < ActiveRecord::Migration[5.2]
  def change
    execute <<-SQL
      INSERT INTO task_actions_users(task_action_id, user_id)
      SELECT task_action_id, user_id FROM task_actions_users_old
    SQL

    drop_table :task_actions_users_old
  end
end
