class CreateTaskActionsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :task_actions_users do |t|
      t.references :task_action, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
