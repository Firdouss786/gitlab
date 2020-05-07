class RenameTransactionTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :transactions, :part_transactions
  end
end
