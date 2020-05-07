class StockItemsController < ApplicationController
  authorize_resource class: false
  before_action :set_stock_item, only: [:show, :edit, :update, :destroy]

  def index
    @stock_items = StockItem.where(stock_location_id: params[:stock_location_id]).where(state: "inspecting")
  end

  def inspecting
  end

  def serviceable
  end

  def installed
  end

  def removed
  end

  def unserviceable
  end

  def transiting
  end

  def quarantined
  end

  def scrapped
  end

  def show
  end

  def new
    @stock_item = StockItem.new
  end

  def edit
  end

  def create
    @stock_item = StockItem.new(stock_item_params)

    respond_to do |format|
      if @stock_item.save
        format.html { redirect_to @stock_item, notice: 'Stock item was successfully created.' }
        format.json { render :show, status: :created, location: @stock_item }
      else
        format.html { render :new }
        format.json { render json: @stock_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @stock_item.update(stock_item_params)
        format.html { redirect_to @stock_item, notice: 'Stock item was successfully updated.' }
        format.json { render :show, status: :ok, location: @stock_item }
      else
        format.html { render :edit }
        format.json { render json: @stock_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @stock_item.destroy
    respond_to do |format|
      format.html { redirect_to stock_items_url, notice: 'Stock item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_stock_item
      @stock_item = StockItem.find(params[:id])
    end

    def stock_item_params
      params.require(:stock_item).permit(:product_id, :serial_number, :model_numbers, :revision, :batch_number, :quantity, :stock_location_id, :shelf_life_expiration, :shelved_at, :user_id, :state)
    end
end
