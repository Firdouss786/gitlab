class Productsubtype < ActiveRecord::Migration[5.1]
  def change
    # Rename
    rename_column :productsubtype, :productsubtype_id, :id

    rename_column :productsubtype, :productsubtype_partnumber, :part_number
    rename_column :productsubtype, :productsubtype_name, :name
    rename_column :productsubtype, :productsubtype_price, :price
    rename_column :productsubtype, :productsubtype_shelflife, :shelf_life
    rename_column :productsubtype, :productsubtype_description, :description
    rename_column :productsubtype, :productsubtype_product_product_id, :product_category_id

    # Remove
    remove_column :productsubtype, :productsubtype_num
    remove_column :productsubtype, :productsubtype_refmtbur

    # Timestamps
    model_name = "productsubtype"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :productsubtype, :products
  end
end
