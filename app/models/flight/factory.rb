class Flight::Factory

  def initialize(aircraft)
    @aircraft = aircraft
    @airline = aircraft.airline
  end

  def call
    REDIS_COUNTER.incr "counter:flight:fetch_collection:#{Time.now.strftime('%Y-%m-%d-%H')}"

    flight_collection.try(:each) do |flight_hash|
      if existing_flight = Flight::Factory.find_by_from_cache(vendor_id: flight_hash['vendor_id'])
        existing_flight.update flight_hash
      else
        created_flight = Flight.create flight_hash.merge(airline: @airline, aircraft: @aircraft)
        Rails.cache.write flight_hash['vendor_id'], created_flight
      end
    end
  end

  def flight_collection
    collection_adapter.new(@aircraft.sanitized_for_api).call
  end

  def self.find_by_from_cache(vendor_id:)
    Rails.cache.fetch(vendor_id) do
      Flight.find_by(vendor_id: vendor_id)
    end
  end

  private

    def collection_adapter
      Flight::Adapters::FlightAware::Collection
    end

end
