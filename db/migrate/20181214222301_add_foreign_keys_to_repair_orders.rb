class AddForeignKeysToRepairOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :repair_orders, :user, foreign_key: true
    add_reference :repair_orders, :origin_stock_location, foreign_key: { to_table: :stock_locations }
    add_reference :repair_orders, :destination_stock_location, foreign_key: { to_table: :stock_locations }
    add_reference :repair_orders, :part_transaction, foreign_key: true
  end
end
