class AddModToTaskTemplates < ActiveRecord::Migration[5.2]
  def change
    add_column :task_templates, :mode, :string
  end
end
