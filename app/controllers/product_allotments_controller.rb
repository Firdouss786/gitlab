class ProductAllotmentsController < ApplicationController
  include FleetScoped

  before_action :set_fleet
  before_action :set_product_allotment, only: [:show, :edit, :update, :destroy]

  authorize_resource class: false

  def index
    @product_allotments = ProductAllotment.where(fleet: @fleet).paginate(per_page: Rails.configuration.pagination_records_per_page, page: params[:page])
  end

  def show
  end

  def new
    @product_allotment = @fleet.product_allotments.new
  end

  def edit
  end

  def create
    @product_allotment = @fleet.product_allotments.new(product_allotment_params)
    respond_to do |format|
      if @product_allotment.save
        format.html { redirect_to product_allotments_path(@product_allotment.fleet), notice: 'Product allotment was successfully created.' }
        format.json { render :show, status: :created, location: @product_allotment }
      else
        format.html { render :new }
        format.json { render json: @product_allotment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product_allotment.update(product_allotment_params)
        format.html { redirect_to product_allotments_path(@product_allotment.fleet), notice: 'Product allotment was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_allotment }
      else
        format.html { render :edit }
        format.json { render json: @product_allotment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product_allotment.destroy
    respond_to do |format|
      format.html { redirect_to product_allotments_url, notice: 'Product allotment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_product_allotment
      @product_allotment = ProductAllotment.find(params[:id])
    end

    def product_allotment_params
      params.require(:product_allotment).permit(:product_id, :quantity, :fleet_id)
    end
end
