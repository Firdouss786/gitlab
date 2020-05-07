class CleanStockItems < ActiveRecord::Migration[5.1]
  def change

    # Make sure rotables have a QTY of 1
    # execute <<-SQL
    #   UPDATE stock_items
    #   JOIN products
    #   ON stock_items.product_id = products.id
    #   SET stock_items.quantity = 1
    #   WHERE products.classification = "ROTABLE"
    # SQL

    # Delete empty stock items
    execute <<-SQL
      DELETE FROM stock_items
      WHERE id IN (34293, 27549, 26139, 18294, 12332, 12147, 12135, 11794, 9763)
    SQL

  end
end
