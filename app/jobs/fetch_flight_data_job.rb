class FetchFlightDataJob < ApplicationJob
  queue_as :flightdata

  def perform(aircraft)
    Flight::Factory.new(aircraft).call
  end

end
