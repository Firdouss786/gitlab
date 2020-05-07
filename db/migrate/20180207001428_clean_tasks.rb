class CleanTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :applicable_content, :string
    add_column :tasks, :applicable_software, :string
    add_column :tasks, :applicability_type, :string
    add_column :tasks, :applicability_id, :integer
    add_column :tasks, :repeat_interval, :integer
    add_column :tasks, :due_at, :datetime

    add_index :tasks, :applicability_id
  end
end
