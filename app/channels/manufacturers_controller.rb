class ManufacturersController < ApplicationController
  include Sortable

  before_action :set_manufacturer, only: [:show, :edit, :update, :destroy]

  def index
    @manufacturers = Manufacturer.search(params[:q]).reorder(sort_pattern).paginate(per_page: Rails.configuration.pagination_records_per_page, page: params[:page])
  end

  def show
  end

  def new
    @manufacturer = Manufacturer.new
  end

  def edit
  end

  def create
    @manufacturer = Manufacturer.new(manufacturer_params)

    respond_to do |format|
      if @manufacturer.save
        format.html { redirect_to manufacturers_url, notice: 'Manufacturer was successfully created.' }
        format.json { render :show, status: :created, location: @manufacturer }
      else
        format.html { render :new }
        format.json { render json: @manufacturer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @manufacturer.update(manufacturer_params)
        format.html { redirect_to manufacturers_url, notice: 'Manufacturer was successfully updated.' }
        format.json { render :show, status: :ok, location: @manufacturer }
      else
        format.html { render :edit }
        format.json { render json: @manufacturer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if has_any_aircrafttypes? && @manufacturer.destroy
        format.html { redirect_to manufacturers_path, notice: 'Manufacturer was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to manufacturers_path, notice: 'Manufacturer has associated AircraftTypes and can not be deleted.' }
        format.json { render json: @manufacturer.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_manufacturer
      @manufacturer = Manufacturer.find(params[:id])
    end

    def manufacturer_params
      params.require(:manufacturer).permit(:name, :description)
    end

    def has_any_aircrafttypes?
      @manufacturer.aircraft_types.count == 0
    end
end
