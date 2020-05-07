class DropCustomerOwnershipFromStockItems < ActiveRecord::Migration[5.1]
  def change
    remove_column :stock_items, :is_customer_owned
    remove_foreign_key :stock_items, name: "fk_stock_item_customer_airline"
    remove_column :stock_items, :airline_id
  end
end
