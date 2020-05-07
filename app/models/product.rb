class Product < ApplicationRecord

  include Searchable

  validates :name, :part_number, :price, presence: true

  enum classification: { consumable: 'consumable'.upcase, rotable: 'rotable'.upcase }

  belongs_to :product_category
  has_many :stock_items
  has_one :corrective_action

  scope :consumables, -> { joins(:product_category).where('product_categories.product_type = "CONSUMABLE"') }
  scope :rotables, -> { joins(:product_category).where('product_categories.product_type = "ROTABLE"') }
  scope :having_same_product_category_of, -> (product_category) { where(product_category: product_category) }
  scope :order_by_part_number, -> { order("part_number ASC") }

  def searchable_attributes
    [part_number, name, price, shelf_life, description, product_category]
  end

  def self.all_in_stock_location(stock_location)
    includes(:stock_items).where(stock_items: { stock_location: stock_location })
  end

end
