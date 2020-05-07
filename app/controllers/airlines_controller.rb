class AirlinesController < ApplicationController
  include AirlineScoped, Sortable
  authorize_resource class: false

  before_action :set_airline, except: [:index, :new, :create]

  def index
    @airlines = Airline.search(params[:q]).reorder(sort_pattern).paginate(per_page: Rails.configuration.pagination_records_per_page, page: params[:page])
  end

  def show
  end

  def new
    @airline = Airline.new
  end

  def edit
  end

  def create
    @airline = Airline.new(airline_params)

    respond_to do |format|
      if @airline.save
        Current.user.airlines << @airline
        format.html { redirect_to airline_flights_path(@airline), notice: 'Airline was successfully created.' }
        format.json { render :show, status: :created, location: @airline }
      else
        format.html { render :new }
        format.json { render json: @airline.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @airline.update(airline_params)
        format.html { redirect_to airlines_path, notice: 'Airline was successfully updated.' }
        format.json { render :show, status: :ok, location: @airline }
      else
        format.html { render :edit }
        format.json { render json: @airline.errors, status: :unprocessable_entity }
      end
    end
  end

  # TODO destroy action
  # def destroy
  #   @airline.disable!
  #   respond_to do |format|
  #     format.html { redirect_to airlines_url, notice: 'Airline was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    def airline_params
      params.require(:airline).permit(:iata_code, :icao_code, :name, :callsign, :country, :description, :customer, :logo)
    end
end
