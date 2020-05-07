class Transaction < ActiveRecord::Migration[5.1]
  def change
    # Remove triggers
    execute <<-SQL
      DROP TRIGGER transaction_audit_insert
    SQL

    execute <<-SQL
      DROP TRIGGER transaction_audit_update
    SQL

    execute <<-SQL
      DROP TRIGGER transaction_audit_delete
    SQL

    # Rename
    rename_column :transaction, :transaction_id, :id

    rename_column :transaction, :transaction_status, :state
    rename_column :transaction, :transaction_type, :category
    rename_column :transaction, :transaction_comment, :comment
    rename_column :transaction, :transaction_airway_bill, :airway_bill
    rename_column :transaction, :transaction_shipper_user_id, :sent_by_user_id
    rename_column :transaction, :transaction_receiver_user_id, :received_by_user_id
    rename_column :transaction, :transaction_stockitem_stock_item_id, :stock_item_id
    rename_column :transaction, :transaction_source_stock_id, :source_stock_location_id
    rename_column :transaction, :transaction_destination_stock_id, :destination_stock_location_id
    rename_column :transaction, :attachment_filename, :filename
    rename_column :transaction, :transaction_open, :sent_at
    rename_column :transaction, :transaction_close, :received_at
    rename_column :transaction, :transaction_user_user_id, :created_by_user_id
    rename_column :transaction, :transaction_activity_activity_id, :activity_id

    # Remove
    remove_column :transaction, :transaction_tracking
    remove_column :transaction, :transaction_investigation_required

    # Timestamps
    model_name = "transaction"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :transaction, :transfers
  end
end
