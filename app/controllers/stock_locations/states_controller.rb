class StockLocations::StatesController < ApplicationController
  include Sortable

  before_action :set_stock_location
  before_action :set_state, only: [:show]
  before_action :state_view_path, only: [:show]

  def index
    @stock_items = @stock_location.stock_items.serviceable
  end

  def show
    @stock_items = @stock_location.stock_items.send(@state)
    render "#{@state_view_path}/show"
  end

  private

  def set_stock_location
    @stock_location = StockLocation.find(params[:stock_location_id])
  end

  def set_state
    # TODO: Better to confirm the state exists with the StockItem model at this point
    @state = params[:id]
  end

  def state_view_path
    @state_view_path = "stock_locations/states/#{@state}"
  end

end
