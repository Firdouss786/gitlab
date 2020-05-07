class Adjustment < ApplicationRecord
  belongs_to :adjustable, polymorphic: true
  has_one :event, as: :eventable

  enum state: { created: 'created', error: 'error' }

  def apply_actions!
    event.stock_item.tap do |stock_item|
      stock_item.quantity += self.quantity
      stock_item.save
    end
  end

  def rollback_actions!
    if not error?
      event.stock_item.tap do |stock_item|
        stock_item.quantity -= self.quantity
        stock_item.save
      end

      self.error!
    end
  end
end
