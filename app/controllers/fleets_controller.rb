class FleetsController < ApplicationController
  include Sortable, AirlineScoped
  authorize_resource class: false

  before_action :set_airline
  before_action :set_fleet, only: [:show, :edit, :update, :destroy, :upload_bom]

  def index
    @fleets = Fleet.where(airline: @airline).search(params[:q]).reorder(sort_pattern).paginate(per_page: Rails.configuration.pagination_records_per_page, page: params[:page])
  end

  def show
  end

  def new
    @fleet = @airline.fleets.new
  end

  def edit
  end

  def create
    @fleet = @airline.fleets.new(configuration_params)

    respond_to do |format|
      if @fleet.save
        format.html { redirect_to airline_fleets_path(@airline), notice: 'Fleet successfully created.' }
        format.json { render :show, status: :created, location: @fleet }
      else
        format.html { render :new }
        format.json { render json: @fleet.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @fleet.update(configuration_params)
        format.html { redirect_to airline_fleets_path(@fleet.airline), notice: 'Fleet successfully updated.' }
        format.json { render :show, status: :ok, location: @fleet }
      else
        format.html { render :edit }
        format.json { render json: @fleet.errors, status: :unprocessable_entity }
      end
    end
  end

  # TODO destroy action
  # def destroy
  #   @fleet.disable!
  #   respond_to do |format|
  #     format.html { redirect_to airline_fleets_path(@fleet.airline), notice: 'Configuration successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    def set_fleet
      @fleet = @airline.fleets.find(params[:id])
    end

    def configuration_params
      params.require(:fleet).permit(:name, :description, :install_type, :first_class_seat_count, :business_class_seat_count, :premium_class_seat_count, :economy_class_seat_count, :aircraft_type_id, :software_platform_id)
    end
end
