class TransfersController < ApplicationController
  authorize_resource class: false

  before_action :set_transfer, only: [:show, :edit, :update, :destroy]

  def index
    @transfers = Transfer.all
  end

  def show
  end

  def new
    @transfer = Transfer.new
  end

  def edit
  end

  def create
    @transfer = TransferConstructor.new(stock_item: stock_item, destination_state: destination_state, destination_stock_location: destination_stock_location, user: Current.user).becomes(Transfer)
    
    respond_to do |format|
      if @transfer.save
        format.html { redirect_to redirection_path, notice: "Transfer complete" }
      else
        format.html { redirect_to redirection_path, alert: @transfer.errors.full_messages.join(', ') }
      end
    end
  end

  private
    def redirection_path
      params.require(:transfer).try(:[], :redirect_to) || root_url
    end

    def transfer_params
      params.require(:transfer).permit(:stock_item_id, :destination_state, :destination_stock_location_id, :redirect_to)
    end

    def stock_item
      StockItem.find transfer_params[:stock_item_id]
    end

    def destination_state
      transfer_params[:destination_state].to_sym
    end

    def destination_stock_location
      StockLocation.find transfer_params[:destination_stock_location_id]
    end

end
