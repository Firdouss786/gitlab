class AddArchivalToTasks < ActiveRecord::Migration[5.2]
  def change
    add_reference :tasks, :archival, index: true
  end
end
