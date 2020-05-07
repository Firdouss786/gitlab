class StationsController < ApplicationController
  include StationScoped, Sortable

  authorize_resource class: false
  before_action :set_station, except: [:index, :create, :new]

  def index
    @stations = Station.search(params[:q]).reorder(sort_pattern).paginate(per_page: Rails.configuration.pagination_records_per_page, page: params[:page])
  end

  def show
  end

  def new
    @station = Station.new
    @station.build_address
  end

  def edit
    @station.address ||= @station.build_address
  end

  def create
    @station = Station.new(station_params)

    respond_to do |format|
      if @station.save
        format.html { redirect_to stations_url, notice: 'Station was successfully created.' }
        format.json { render :show, status: :created, location: @station }
      else
        format.html { render :new }
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @station.update(station_params)
        format.html { redirect_to stations_url, notice: 'Station was successfully updated.' }
        format.json { render :show, status: :ok, location: @station }
      else
        format.html { render :edit }
        format.json { render json: @station.errors, status: :unprocessable_entity }
      end
    end
  end

  # def destroy
  #   @station.destroy
  #   respond_to do |format|
  #     format.html { redirect_to stations_url, notice: 'Station was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    def station_params
      params.require(:station).permit(:airport_id, :user_id, :name, address_attributes: [:id, :street1, :street2, :city, :state, :zip, :country, :phone])
    end

end
