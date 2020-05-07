class AircraftsController < ApplicationController
  include Sortable, FleetScoped
  authorize_resource class: false

  before_action :set_aircraft, only: [:show, :edit, :update, :destroy]
  before_action :set_config, only: [:index, :new, :create]
  before_action :set_fleet
  before_action :set_airline

  def index
    @aircrafts = Aircraft.where(fleet: @fleet).search(params[:q]).reorder(sort_pattern).paginate(per_page: Rails.configuration.pagination_records_per_page, page: params[:page])
  end

  def show
  end

  def new
    @aircraft = @fleet.aircrafts.new
  end

  def edit
  end

  def create
    @aircraft = @fleet.aircrafts.new(aircraft_params)

    respond_to do |format|
      if @aircraft.save
        format.html { redirect_to aircrafts_path(@aircraft.fleet), notice: 'Aircraft was successfully created.' }
        format.json { render :show, status: :created, location: @aircraft }
      else
        format.html { render :new }
        format.json { render json: @aircraft.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @aircraft.update(aircraft_params)
        format.html { redirect_to aircrafts_path(@aircraft.fleet), notice: 'Aircraft was successfully updated.' }
        format.json { render :show, status: :ok, location: @aircraft }
      else
        format.html { render :edit }
        format.json { render json: @aircraft.errors, status: :unprocessable_entity }
      end
    end
  end

  # TODO
  # def destroy
  #   @aircraft.disable!
  #   respond_to do |format|
  #     format.html { redirect_to fleet_aircrafts_path(@aircraft.fleet), notice: 'Aircraft was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    def set_aircraft
      @aircraft = Aircraft.find(params[:id])
    end

    def set_config
      @fleet = Fleet.find(params[:fleet_id])
    end

    def set_airline
      @airline = @fleet.airline
    end

    def aircraft_params
      params.require(:aircraft).permit(:tail, :msn, :fin, :registration, :eis, :tot, :description, :fleet_id, :locked, :active)
    end
end
