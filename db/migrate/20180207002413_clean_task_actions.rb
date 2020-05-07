class CleanTaskActions < ActiveRecord::Migration[5.1]
  def change
    rename_column :task_actions, :taskcard_id, :task_id
  end
end
