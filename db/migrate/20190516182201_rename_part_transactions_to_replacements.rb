class RenamePartTransactionsToReplacements < ActiveRecord::Migration[6.0]
  def change
    rename_table :part_transactions, :replacements
  end
end
