class AddArchivalToTaskTemplates < ActiveRecord::Migration[5.2]
  def change
    add_reference :task_templates, :archival, index: true
  end
end
