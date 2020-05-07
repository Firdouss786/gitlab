class Replacement < ApplicationRecord

  before_save :remove_unnecessary_params
  before_save :assign_parsed_model_numbers, if: -> { rotable? and removed_model_numbers? }

  belongs_to :installed_product, class_name: "Product"
  belongs_to :installed_stock_item, class_name: "StockItem"
  belongs_to :removed_product, class_name: "Product", optional: true
  belongs_to :removed_stock_item, class_name: "StockItem", optional: true
  belongs_to :removal_reason, optional: true
  has_many :adjustments, as: :adjustable
  has_one :corrective_action

  enum category: { consumable: "consumable", rotable: "rotable"}

  validates :category, presence: true

  with_options unless: -> { category != 'consumable' } do |consumable|
    consumable.validates :install_quantity, presence: true
    consumable.validates_inclusion_of :installed_product, in: :aircraft_bom_consumables, message: "must be a consumable in BOM of selected aircraft", if: -> { installed_product_id? }
    consumable.validates_inclusion_of :installed_stock_item, in: :batch_available, message: "must be a batch of selected product, available in stock at workpack station and servicable", if: -> { installed_stock_item_id? }
    consumable.validates_inclusion_of :install_quantity, in: :batch_quantity_available, message: "must be > 0 and <= quantity_available", if: -> { install_quantity.present? }
  end

  with_options if: :rotable? do |rotable|
    rotable.validates :on_wing_position, :removed_product, presence: true
    rotable.with_options unless: -> { removed_product.blank? } do |r|
      r.validates_inclusion_of :removed_product, in: :aircraft_bom_rotables, message: "must be a rotable in BOM of selected aircraft"
      r.validates_inclusion_of :removed_stock_item, in: :removed_stock_item_was_installed, message: "serial off number must be under selected product off and previously installed"
      r.validate :removed_model_numbers_in_range, if: -> { removed_model_numbers? }
      r.validates_inclusion_of :removed_revision, in: ("A".."Z"), message: "must be in caps and between A and Z", if: -> { removed_revision? }
      r.validates_inclusion_of :installed_product, in: :aircraft_bom_rotables_of_same_category, message: "must be a rotable and in similar category of removed product", if: -> { installed_product_id? }
      r.validates_inclusion_of :installed_stock_item, in: :serial_available, message: "must be a serial of selected product, available in stock at workpack station and servicable", if: -> { installed_product_id? && installed_stock_item_id? }
    end
  end

  before_commit on: :create, if: :consumable? do
    installed_stock_item.consume quantity: self.install_quantity, adjustable: self
  end

  before_commit on: :update, if: :consumable? do
    rollback_all_adjustments!
    installed_stock_item.consume quantity: self.install_quantity, adjustable: self
  end

  before_commit on: :create, if: :rotable? do
    # installed_stock_item.install
    # removed_stock_item.uninstall
  end

  before_commit on: :update, if: :rotable? do
  end

  private
    def rollback_all_adjustments!
      adjustments.each(&:rollback_actions!)
    end

    def aircraft_bom_consumables
      self.corrective_action.activity.aircraft.bill_of_materials.consumables
    end

    def batch_available
      StockItem.at_station(self.corrective_action.activity.station).for_product(self.installed_product.id).available_in_stock.is_serviceable
    end

    def batch_quantity_available
      Array (1..StockItem.find(self.installed_stock_item.id).quantity)
    end

    def aircraft_bom_rotables
      self.corrective_action.activity.aircraft.bill_of_materials.rotables
    end

    def removed_stock_item_was_installed
      StockItem.for_product(self.removed_product.id).was_installed
    end

    def removed_model_numbers_in_range
      valid_range = (1..16).to_a
      given_range = parse_model_numbers(removed_model_numbers) || parse_model_numbers(removed_model_numbers.split(",").to_s)
      if given_range.present?
        errors.add(:removed_model_numbers, "must be between 1 and 16") if (given_range - valid_range).present?
      end
    end

    def parse_model_numbers(string)
      JSON.parse(string).map { |x| x.to_i if Integer(x) rescue nil }.compact rescue nil
    end

    def assign_parsed_model_numbers
      self.removed_model_numbers = parse_model_numbers(self.removed_model_numbers).join(",")
    end

    def aircraft_bom_rotables_of_same_category
      self.corrective_action.activity.aircraft.bill_of_materials.having_same_product_category_of(self.removed_product.product_category).rotables
    end

    def serial_available
      StockItem.at_station(corrective_action.activity.station).for_product(installed_product.id).available_in_stock.is_serviceable
    end

    def remove_unnecessary_params
      if consumable?
        self.on_wing_position = nil
        self.removed_product = nil
        self.removed_stock_item = nil
        self.removed_model_numbers = nil
        self.removed_revision = nil
      elsif rotable?
        self.install_quantity = nil
      end
    end

end
