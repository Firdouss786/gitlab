class IndexBatchNumberOnStockItems < ActiveRecord::Migration[6.0]
  def change
    add_index :stock_items, :batch_number
  end
end
