class StockItems::EventsController < ApplicationController
  
  def index
    @stock_item = StockItem.find(params[:stock_item_id])
    @events = @stock_item.events.order("created_at DESC")
  end

  # TODO: Mark event as error
  def destroy
  end
end
