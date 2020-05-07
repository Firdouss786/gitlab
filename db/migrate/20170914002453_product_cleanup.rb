class ProductCleanup < ActiveRecord::Migration[5.1]
  def change
    # Rename
    rename_column :product, :product_id, :id

    rename_column :product, :product_name, :name
    rename_column :product, :product_description, :description

    # Remove
    remove_column :product, :product_manufacturer
    remove_column :product, :product_category
    # Going to use this later to determin if product is ROTABLE / CONSUMABLE
    # remove_column :product, :product_type
    remove_column :product, :product_typenum
    remove_column :product, :product_abccode

    # Timestamps
    model_name = "product"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :product, :product_categories
  end
end
