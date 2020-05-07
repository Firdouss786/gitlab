class FlightsController < ApplicationController
  include AirlineScoped

  before_action :set_airline

  def index
    @flights = @airline.flights.where(updated_at: (3.days.ago)..(5.days.from_now)).enroute
  end

end
