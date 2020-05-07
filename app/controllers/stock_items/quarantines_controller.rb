class StockItems::QuarantinesController < ApplicationController
  before_action :set_stock_location, only: [:index]
  layout "logistics"

  def index
    @stock_items = @stock_location.stock_items.quarantined
  end

  private
    def set_stock_location
      @stock_location = StockLocation.find(params[:stock_location_id])
    end
end
