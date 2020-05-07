class Transfer < ApplicationRecord
  validates :stock_item, :source_stock_location, :destination_stock_location, :sent_at, :created_by, :from_state, :to_state, presence: true

  belongs_to :sent_by, class_name: "User"
  belongs_to :received_by, class_name: "User"
  belongs_to :stock_item
  belongs_to :source_stock_location, class_name: "StockLocation"
  belongs_to :destination_stock_location, class_name: "StockLocation"
  belongs_to :created_by, class_name: "User"

  def self.ordered
    order("sent_at DESC")
  end

  scope :is_open, -> { where(state: "OPEN") }

  after_create :transition_stock_item

  def transition_stock_item
    stock_item.transition_to_state to_state
  end

end
