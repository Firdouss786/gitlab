class Project < ActiveRecord::Migration[5.1]
  def change
    # Rename
    rename_column :project, :project_id, :id

    rename_column :project, :project_station_station_id, :station_id
    rename_column :project, :project_user_user_id, :user_id
    rename_column :project, :project_name, :name
    rename_column :project, :project_description, :description

    # Timestamps
    model_name = "project"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :project, :projects
  end
end
