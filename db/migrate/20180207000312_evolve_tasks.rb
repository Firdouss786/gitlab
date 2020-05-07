class EvolveTasks < ActiveRecord::Migration[5.1]
  def change
    rename_table :taskcard_actions, :task_actions
    rename_table :taskcard_actions_users, :task_actions_users
    rename_table :taskcard_templates, :task_templates
    rename_table :taskcards, :tasks
  end
end
