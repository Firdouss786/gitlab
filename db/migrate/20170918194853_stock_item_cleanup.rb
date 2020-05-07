class StockItemCleanup < ActiveRecord::Migration[5.1]
  def change
    # Remove triggers
    execute <<-SQL
      DROP TRIGGER stockitem_audit_insert
    SQL

    execute <<-SQL
      DROP TRIGGER stockitem_audit_update
    SQL

    execute <<-SQL
      DROP TRIGGER stockitem_audit_delete
    SQL

    # Rename
    rename_column :stock_item, :stock_item_id, :id

    rename_column :stock_item, :stockitem_product_sub_type_productsubtype_id, :product_id
    rename_column :stock_item, :stock_item_serial_number, :serial_number
    rename_column :stock_item, :stock_item_model, :model_numbers
    rename_column :stock_item, :stock_item_revision, :revision
    rename_column :stock_item, :stockitem_batch, :batch_number
    rename_column :stock_item, :stockitem_type, :category
    rename_column :stock_item, :stockitem_consummable_quantity, :quantity
    rename_column :stock_item, :stock_item_stock_stock_id, :stock_location_id
    rename_column :stock_item, :stock_item_shelflifeexpiration, :shelf_life_expiration
    rename_column :stock_item, :stock_item_ontheshelf, :shelved_at
    rename_column :stock_item, :stock_item_customerowned, :is_customer_owned
    rename_column :stock_item, :stock_item_customer_airline_id, :airline_id
    rename_column :stock_item, :stockitem_user_user_id, :user_id
    rename_column :stock_item, :stockitem_lasttransaction_transaction_id, :lastest_transfer_id

    # Add state column
    add_column :stock_item, :state, :string

    # Remove
    remove_column :stock_item, :stock_item_freebee

    # Timestamps
    model_name = "stock_item"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :stock_item, :stock_items
  end
end
