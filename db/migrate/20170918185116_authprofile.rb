class Authprofile < ActiveRecord::Migration[5.1]
  def change
    # Rename
    rename_column :authprofile, :authprofile_id, :id

    rename_column :authprofile, :authprofile_name, :name
    rename_column :authprofile, :aiuthprofile_comment, :description

    # Timestamps
    model_name = "authprofile"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :authprofile, :profiles
  end
end
