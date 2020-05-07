class MigrateBatchConsumptionsToReplacements

  # We dont want any callbacks or validations to run
  class Replacement < ApplicationRecord
  end

  class StockItem < ApplicationRecord
    after_create do
      MigrateBatchConsumptionsToReplacements::Transfer.create(
        state: "CLOSE",
        category: "CREATION",
        comment: "Created during Servo 2 migration. A corrective action contained a batch number which was orphaned from the StockItem",
        stock_item_id: self.id,
        destination_stock_location_id: self.stock_location_id,
        sent_at: Time.now,
        received_at: Time.now,
        created_by_id: self.user_id,
        sent_by_id: self.user_id,
        received_by_id: self.user_id,
        from_state: "CREATION",
        to_state: "CREATION"
      )
    end
  end

  class Transfer < ApplicationRecord
  end

  attr_accessor :corrective_action, :stock_item, :replacement, :transfer, :dest_stock_location_id, :user_id

  def initialize(corrective_action, dest_stock_location_id, user_id)
    @corrective_action = corrective_action
    @stock_item = StockItem.find_by(batch_number: corrective_action.batch_number, product_id: corrective_action.product_id)
    @transfer = nil
    @replacement = nil
    @dest_stock_location_id = dest_stock_location_id
    @user_id = user_id
  end

  def self.perform(days_ago: 30, dest_stock_location_id: 593, user_id: 74)
    corrective_actions_with_consumables(days_ago).each do |corrective_action|
      self.new(corrective_action, dest_stock_location_id, user_id).tap do |script|
        script.new_stock_item unless script.stock_item
        script.new_replacement
        script.save
      end
    end
  end

  def new_stock_item
    @stock_item = MigrateBatchConsumptionsToReplacements::StockItem.new(
      product_id: @corrective_action.product.id,
      batch_number: @corrective_action.batch_number,
      category: "consumable",
      quantity: 0,
      stock_location_id: @dest_stock_location_id,
      state: "quarantined",
      user_id: @user_id
    )
  end

  def new_replacement
    @replacement = MigrateBatchConsumptionsToReplacements::Replacement.new(
      installed_stock_item_id: @stock_item.id,
      install_quantity: @corrective_action.batch_quantity,
      category: "consumable",
      installed_product_id: @corrective_action.product.id
    )
  end

  def new_transfer

  end

  def save
    @stock_item.save if @stock_item.changed?
    @replacement.save if @replacement.changed?
  end

  private
    def self.corrective_actions_with_consumables(days_ago)
      CorrectiveAction.where("created_at > ?", days_ago.days.ago).where.not(batch_number: nil).uniq
    end

end
