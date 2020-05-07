class CleanTaskTemplates < ActiveRecord::Migration[5.1]
  def change
    add_column :task_templates, :applicable_content, :string
    add_column :task_templates, :applicable_software, :string
    add_column :task_templates, :applicability_type, :string
    add_column :task_templates, :applicability_id, :integer
    add_column :task_templates, :repeat_interval, :integer
    add_column :task_templates, :state, :string
    add_column :task_templates, :airline_id, :integer

    add_index :task_templates, :airline_id
    add_index :task_templates, :applicability_id
  end
end
