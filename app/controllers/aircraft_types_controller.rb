class AircraftTypesController < ApplicationController
  authorize_resource class: false
  before_action :set_aircraft_type, only: [:show, :edit, :update, :destroy]
  # GET /aircraft_types
  # GET /aircraft_types.json
  def index
    @aircraft_types = AircraftType.all
  end

  # GET /aircraft_types/1
  # GET /aircraft_types/1.json
  def show
  end

  # GET /aircraft_types/new
  def new
    @aircraft_type = AircraftType.new
  end

  # GET /aircraft_types/1/edit
  def edit
  end

  # POST /aircraft_types
  # POST /aircraft_types.json
  def create
    @aircraft_type = AircraftType.new(aircraft_type_params)

    respond_to do |format|
      if @aircraft_type.save
        format.html { redirect_to @aircraft_type, notice: 'Aircraft type was successfully created.' }
        format.json { render :show, status: :created, location: @aircraft_type }
      else
        format.html { render :new }
        format.json { render json: @aircraft_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /aircraft_types/1
  # PATCH/PUT /aircraft_types/1.json
  def update
    respond_to do |format|
      if @aircraft_type.update(aircraft_type_params)
        format.html { redirect_to @aircraft_type, notice: 'Aircraft type was successfully updated.' }
        format.json { render :show, status: :ok, location: @aircraft_type }
      else
        format.html { render :edit }
        format.json { render json: @aircraft_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aircraft_types/1
  # DELETE /aircraft_types/1.json
  def destroy
    @aircraft_type.destroy
    respond_to do |format|
      format.html { redirect_to aircraft_types_url, notice: 'Aircraft type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aircraft_type
      @aircraft_type = AircraftType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def aircraft_type_params
      params.require(:aircraft_type).permit(:name, :description, :manufacturer_id)
    end
end
