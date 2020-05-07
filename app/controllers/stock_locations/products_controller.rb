class StockLocations::ProductsController < ApplicationController
  before_action :set_stock_location

  # GET    /stock_locations/:stock_location_id/products
  def index
    @products = Product.all_in_stock_location @stock_location
  end

  private
    def set_stock_location
      @stock_location = StockLocation.find(params[:stock_location_id])
    end
end
