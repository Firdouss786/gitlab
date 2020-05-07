class Taskcard < ActiveRecord::Migration[5.1]
  def change
    # Rename
    rename_column :taskcard, :taskcard_id, :id

    rename_column :taskcard, :taskcard_name, :name
    rename_column :taskcard, :taskcard_description, :description

    # Remove
    remove_column :taskcard, :taskcard_attachment
    remove_column :taskcard, :taskcard_attachment_link


    # Timestamps
    model_name = "taskcard"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :taskcard, :taskcard_templates
  end
end
