class Oem < ActiveRecord::Migration[5.1]
  def change
    # Rename
    rename_column :oem, :oem_id, :id

    rename_column :oem, :oem_name, :name
    rename_column :oem, :oem_description, :description

    # Timestamps
    model_name = "oem"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :oem, :manufacturers
  end
end
