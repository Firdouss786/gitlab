class DropApplicableContentAndSoftwareFromTaskTemplates < ActiveRecord::Migration[5.2]
  def change
    remove_column :task_templates, :applicable_content
    remove_column :task_templates, :applicable_software 
  end
end
