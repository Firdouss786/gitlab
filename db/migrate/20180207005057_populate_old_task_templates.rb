class PopulateOldTaskTemplates < ActiveRecord::Migration[5.1]
  def change
    execute <<-SQL
      UPDATE task_templates
      SET airline_id = 780,
      state = "terminated",
      applicability_type = "Aircraft",
      applicability_id = 1351
      WHERE airline_id is NULL
    SQL
  end
end
