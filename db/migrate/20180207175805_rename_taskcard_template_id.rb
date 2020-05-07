class RenameTaskcardTemplateId < ActiveRecord::Migration[5.1]
  def change
    rename_column :tasks, :taskcard_template_id, :task_template_id
  end
end
