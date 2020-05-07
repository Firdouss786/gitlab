class AddDefaultValueToTaskState < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :state, :string, default: "created"
  end
end
