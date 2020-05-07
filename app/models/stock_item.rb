class StockItem < ApplicationRecord
  include AASM
  include StockItem::Adjustable

  belongs_to :product
  belongs_to :stock_location
  belongs_to :user
  has_many :certificates, autosave: true
  has_many :events
  has_many :transfers

  scope :is_serviceable, -> { where(state: 'serviceable') }
  scope :was_installed, -> { where(state: 'installed') }
  scope :available_in_stock, -> { where('quantity > ?', 0) }
  scope :at_station, -> (station) { where(stock_location: station) }
  scope :for_product, -> (product) { where(product_id: product) }
  scope :order_by_batch_number, -> { order("batch_number ASC") }
  scope :order_by_serial_number, -> { order("serial_number ASC") }

  with_options if: :rotable? do |rotable|
    rotable.validates :serial_number, presence: true
    rotable.validates :serial_number, uniqueness: { scope: :product, case_sensitive: false }
    rotable.validates_numericality_of :quantity, :greater_than_or_equal_to => 1
  end

  with_options if: :consumable? do |consumable|
    consumable.validates :batch_number, presence: true
    consumable.validates :batch_number, uniqueness: { scope: :product, case_sensitive: false }
    consumable.validates_numericality_of :quantity, :greater_than_or_equal_to => 0
  end

  enum category: { consumable: "consumable", rotable: "rotable"}

  enum state: { inspecting: 'inspecting', serviceable: 'serviceable', installed: 'installed', removed: 'removed', unserviceable: 'unserviceable', transiting: 'transiting', quarantined: 'quarantined', scrapped: 'scrapped' }

  validate { @current_state.validate }

  attr_accessor :current_state

  after_initialize do
    @current_state = "StockItem::#{state.humanize}State".constantize.new(self)
  end


  def name
    rotable? ? serial_number : batch_number
  end

  def transition_to_state(state)
    if @current_state.valid_destination_states.include? state.to_sym
      self.update state: state
    end

    self.restore_attributes if invalid?
    self
  end


end
