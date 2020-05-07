class FlightSubscriptionsController < ApplicationController
  include AirlineScoped, Sortable

  before_action :set_airline

  def index
    @sortable_columns = ['tail']
    @aircrafts = @airline.aircrafts.search(params[:q]).reorder(sort_pattern).paginate(per_page: Rails.configuration.pagination_records_per_page, page: params[:page])
  end

  def create
    @aircraft = Aircraft.find(params[:aircraft_id])
    @aircraft.subscribe_flights

    respond_to do |format|
      format.html { redirect_to airline_flight_subscriptions_path, notice: 'Initialized subscription request with Flight Aware' }
    end
  end

  def subscribe_all_aircrafts
    @airline.aircrafts.each { |aircraft| aircraft.subscribe_flights }

    respond_to do |format|
      format.html { redirect_to airline_flight_subscriptions_path(@airline), notice: 'Initialized subscription request with Flight Aware' }
    end
  end

  def destroy
    @flight_subscription = Flight::Subscription.find(params[:id])
    @flight_subscription.deregister

    respond_to do |format|
      format.html { redirect_to airline_flight_subscriptions_path(@flight_subscription.aircraft.airline), notice: 'Subscription queued for deletion' }
    end
  end

end
