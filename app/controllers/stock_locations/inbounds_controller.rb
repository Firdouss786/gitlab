class StockLocations::InboundsController < ApplicationController
  before_action :set_stock_location

  # GET    /stock_locations/:stock_location_id/inbounds
  def index
    @transfers = Transfer.where(destination_stock_location: @stock_location).is_open
  end

  private
    def set_stock_location
      @stock_location = StockLocation.find(params[:stock_location_id])
    end
end
