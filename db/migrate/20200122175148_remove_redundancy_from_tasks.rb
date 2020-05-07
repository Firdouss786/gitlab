class RemoveRedundancyFromTasks < ActiveRecord::Migration[6.0]
  def change
    remove_column :tasks, :applicable_content
    remove_column :tasks, :applicable_software
    remove_column :tasks, :applicability_type
    remove_column :tasks, :applicability_id
    remove_column :tasks, :repeat_interval
    remove_column :tasks, :name
    remove_column :tasks, :description
    remove_column :tasks, :archival_id
  end
end
