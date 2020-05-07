class MigrateBatchConsumptions < ActiveRecord::Migration[6.0]

  # class CorrectiveAction < ApplicationRecord
  #   belongs_to :replacement, optional: true
  #
  #   def self.consumptions
  #     where.not(batch_number: nil)
  #   end
  # end
  #
  # def up
  #   CorrectiveAction.consumptions.each do |consumption|
  #     puts "Updating Corrective Action: #{consumption.id}"
  #
  #     stock_item = StockItem.find_by batch_number: consumption.batch_number
  #
  #     replacement = Replacement.create(
  #       install_quantity: consumption.batch_quantity,
  #       installed_stock_item: stock_item,
  #       category: "consumable"
  #     )
  #
  #     consumption.update replacement: replacement
  #   end
  # end
  #
  # def down
  #
  # end
end
