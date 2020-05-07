class DropTypeFromTaskTemplates < ActiveRecord::Migration[5.2]
  def change
    remove_column :task_templates, :applicability_type
    remove_column :task_templates, :applicability_id
  end
end
