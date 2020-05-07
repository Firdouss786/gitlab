class AirportsController < ApplicationController
  include Sortable
  authorize_resource class: false

  before_action :set_airport, only: [:show, :edit, :update, :destroy]

  def index
    @airports = Airport.search(params[:q]).reorder(sort_pattern).paginate(per_page: Rails.configuration.pagination_records_per_page, page: params[:page])
  end

  def show
  end

  def new
    @airport = Airport.new
  end

  def edit
  end

  def create
    @airport = Airport.new(airport_params)

    respond_to do |format|
      if @airport.save
        format.html { redirect_to airports_url, notice: 'Airport was successfully created.' }
        format.json { render :show, status: :created, location: @airport }
      else
        format.html { render :new }
        format.json { render json: @airport.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @airport.update(airport_params)
        format.html { redirect_to airports_url, notice: 'Airport was successfully updated.' }
        format.json { render :show, status: :ok, location: @airport }
      else
        format.html { render :edit }
        format.json { render json: @airport.errors, status: :unprocessable_entity }
      end
    end
  end

  # def destroy
  #   @airport.destroy
  #   respond_to do |format|
  #     format.html { redirect_to airports_url, notice: 'Airport was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    def set_airport
      @airport = Airport.find(params[:id])
    end

    def airport_params
      params.require(:airport).permit(:iata_code, :icao_code, :name, :country, :city, :latitude, :longitude, :dst, :timezone)
    end
end
