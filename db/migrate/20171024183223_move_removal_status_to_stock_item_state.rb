class MoveRemovalStatusToStockItemState < ActiveRecord::Migration[5.1]
  def change

    # Move turnin status to stock item state then unset the flag
    execute <<-SQL
      UPDATE stock_items
        JOIN transactions
        ON transactions.`removed_stock_item_id` = stock_items.id
      SET stock_items.state = "removed",
        transactions.`removal_status` = 0
      WHERE transactions.`removal_status` = 1
      AND stock_items.state = "installed"
    SQL

    # Unset the flag for stock items which should have one (ie they are in quarantine)
    execute <<-SQL
      UPDATE stock_items
        JOIN transactions
        ON transactions.`removed_stock_item_id` = stock_items.id
      SET transactions.`removal_status` = 0
      WHERE transactions.`removal_status` = 1
    SQL

    # Remove the old status column
    remove_column :transactions, :removal_status
  end
end
