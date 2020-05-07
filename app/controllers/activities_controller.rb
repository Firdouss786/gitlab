class ActivitiesController < ApplicationController
  include StationScoped, ActivityScoped
  authorize_resource class: false

  before_action :set_station, only: [:index, :new, :create]
  before_action :set_activity, only: [:show, :open, :edit, :update]

  layout "activity", only: [:show, :open]

  def index
    @activities = @station.activities.search(params[:q]).eligible_for_work
    if arriving?
      @activities = @activities.search(params[:q]).arriving
    elsif landed?
      @activities = @activities.search(params[:q]).landed
    end
  end

  def show
  end

  def new
    @activity = Activity.new

    # When user selects an aircraft, show them any outstanding activities
    @aircraft = Aircraft.find_by(id: params[:aircraft_id])
    @activities = @station.activities.eligible_for_work.where(aircraft: @aircraft)
  end

  def edit
    @aircraft = @activity.aircraft
  end

  def open
    respond_to do |format|
      if @activity.transition_to_state(:active) && @activity.update(additional_attributes)
        format.html { redirect_to @activity }
      else
        format.html { render :show }
      end
    end
  end

  def create
    @activity = @station.activities.new(activity_params)

    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url, notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def activity_params
      params.require(:activity).permit(:boarded_at, :unboarded_at, :station_id, :inbound_flight_number, :inbound_airport_id, :outbound_airport_id, :outbound_flight_number, :aircraft_id, :flight_id)
    end

    def arriving?
      params[:filter] === "arriving"
    end

    def landed?
      params[:filter] === "landed"
    end

    def additional_attributes
      flight = @activity.flight
      next_flight = flight.try(:next_flight)

      attributes = { boarded_at: Time.now }
      attributes.merge! ({ inbound_airport_id: flight.origin_airport_id, inbound_flight_number: flight.flight_number }) if flight
      attributes.merge! ({ outbound_airport_id: next_flight.destination_airport_id, outbound_flight_number: next_flight.flight_number }) if next_flight
      attributes
    end

end
