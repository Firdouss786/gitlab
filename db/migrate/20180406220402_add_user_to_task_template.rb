class AddUserToTaskTemplate < ActiveRecord::Migration[5.2]
  def change
    add_column :task_templates, :user, :integer
    add_reference :task_templates, :user, foreign_key: true
  end
end
