class ChangeColumnDefaultInTasks < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :completion_percentage, :integer, default: 0
  end
end
