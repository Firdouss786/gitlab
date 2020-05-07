class Aircrafts::FlightsController < ApplicationController

  def index
    @aircraft = Aircraft.find(params[:aircraft_id])
    @airline = @aircraft.airline
    @flights = @aircraft.flights
  end

end
