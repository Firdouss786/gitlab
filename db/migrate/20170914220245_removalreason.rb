class Removalreason < ActiveRecord::Migration[5.1]
  def change
    # Rename
    rename_column :removalreason, :removalreason_id, :id

    rename_column :removalreason, :removalreason_name, :name
    rename_column :removalreason, :removalreason_product_product_id, :product_category_id
    rename_column :removalreason, :removalreason_description, :description

    # Timestamps
    model_name = "removalreason"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :removalreason, :removal_reasons
  end
end
