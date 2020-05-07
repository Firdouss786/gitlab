class StockItems::OutboundsController < ApplicationController
  before_action :set_stock_location, only: [:index]
  layout "logistics"

  def index
    @stock_items = StockItem.transiting_from stock_location: @stock_location
  end

  private
    def set_stock_location
      @stock_location = StockLocation.find(params[:stock_location_id])
    end
end
