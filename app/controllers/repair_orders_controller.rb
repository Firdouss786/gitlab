class RepairOrdersController < ApplicationController
  authorize_resource class: false
  before_action :set_repair_order, only: [:show, :edit, :update, :destroy]

  # GET /repair_orders
  # GET /repair_orders.json
  def index
    @repair_orders = RepairOrder.all
  end

  # GET /repair_orders/1
  # GET /repair_orders/1.json
  def show
  end

  # GET /repair_orders/new
  def new
    @repair_order = RepairOrder.new
  end

  # GET /repair_orders/1/edit
  def edit
  end

  # POST /repair_orders
  # POST /repair_orders.json
  def create
    @repair_order = RepairOrder.new(repair_order_params)

    respond_to do |format|
      if @repair_order.save
        format.html { redirect_to @repair_order, notice: 'Repair order was successfully created.' }
        format.json { render :show, status: :created, location: @repair_order }
      else
        format.html { render :new }
        format.json { render json: @repair_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /repair_orders/1
  # PATCH/PUT /repair_orders/1.json
  def update
    respond_to do |format|
      if @repair_order.update(repair_order_params)
        format.html { redirect_to @repair_order, notice: 'Repair order was successfully updated.' }
        format.json { render :show, status: :ok, location: @repair_order }
      else
        format.html { render :edit }
        format.json { render json: @repair_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repair_orders/1
  # DELETE /repair_orders/1.json
  def destroy
    @repair_order.destroy
    respond_to do |format|
      format.html { redirect_to repair_orders_url, notice: 'Repair order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repair_order
      @repair_order = RepairOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def repair_order_params
      params.require(:repair_order).permit(:user_id, :origin_stock_location_id, :destination_stock_location_id, :part_transaction_id)
    end
end
