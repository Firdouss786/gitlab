class Bomitem < ActiveRecord::Migration[5.1]
  def change
    # Rename
    rename_column :bomitem, :bomitem_id, :id

    remove_foreign_key :bom, name: "fk_bom_bom_configuration_26"
    remove_foreign_key :bomitem, name: "fk_bomitem_bomitem_bom_28"

    execute <<-SQL
      UPDATE bomitem
      JOIN bom
      ON bomitem.bomitem_bom_bom_id = bom.bom_id
      SET bomitem.bomitem_bom_bom_id = bom.bom_configuration_configuration_id
    SQL

    rename_column :bomitem, :bomitem_productsubtype_productsubtype_id, :product_id
    rename_column :bomitem, :bomitem_quantity, :quantity
    rename_column :bomitem, :bomitem_bom_bom_id, :configuration_id

    # Timestamps
    model_name = "bomitem"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :bomitem, :product_allotments
  end
end
