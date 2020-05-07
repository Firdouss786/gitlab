class StockLocationsController < ApplicationController
  include StationScoped

  authorize_resource class: false

  before_action :set_station
  before_action :set_stock_location, only: [:show, :edit, :update, :destroy]

  def index
    @stock_locations = @station.stock_locations
  end

  def show
    @inbound_transfers_count = StockItem.transiting_to(@stock_location).count
    @turnin_transfers_count = StockItem.removed.count
    @unserviceable_transfers_count = StockItem.at_location(@stock_location).unserviceable.count
  end

  def new
    @stock_location = StockLocation.new
  end

  def edit
  end

  def create
    @stock_location = StockLocation.new(stock_location_params)

    respond_to do |format|
      if @stock_location.save
        format.html { redirect_to @stock_location, notice: 'Stock location was successfully created.' }
        format.json { render :show, status: :created, location: @stock_location }
      else
        format.html { render :new }
        format.json { render json: @stock_location.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @stock_location.update(stock_location_params)
        format.html { redirect_to @stock_location, notice: 'Stock location was successfully updated.' }
        format.json { render :show, status: :ok, location: @stock_location }
      else
        format.html { render :edit }
        format.json { render json: @stock_location.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @stock_location.destroy
    respond_to do |format|
      format.html { redirect_to stock_locations_url, notice: 'Stock location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_stock_location
      @stock_location = @station.stock_locations.find(params[:id])
    end

    def stock_location_params
      params.require(:stock_location).permit(:name, :category, :parent_id, :parent_type)
    end
end
