class Flight::Adapters::FlightAware::FlightInfoEx
  include ActiveModel::Model

  attr_reader :vendor_id, :flight_number, :aircraft_type, :filed_ete, :filed_time, :filed_departure_time, :filed_airspeed_kts,
              :filed_airspeed_mach, :filed_altitude, :route, :actual_departure_time, :estimated_arrival_time, :actual_arrival_time,
              :diverted, :origin_airport_code, :destination_airport_code, :origin_airport_name, :origin_city_name,
              :destination_airport_name, :destination_city_name

  validates_presence_of :vendor_id, :flight_number, :filed_departure_time, :estimated_arrival_time

  validate do
    self.errors.add(:filed_departure_time, "is too far in the past or future (10 days)") unless ((10.days.ago)..(10.days.from_now)).include?(@filed_departure_time)
  end

  validate do
    self.errors.add(:estimated_arrival_time, "is too far in the past or future (10 days)") unless ((10.days.ago)..(10.days.from_now)).include?(@estimated_arrival_time)
  end

  # SETTERS

  def faFlightID=(attr)
    @vendor_id = attr if type_check(attr, String)
  end

  def ident=(attr)
    @flight_number = attr if type_check(attr, String)
  end

  def aircrafttype=(attr)
    @aircraft_type = attr if type_check(attr, String)
  end

  def filed_ete=(attr)
    @filed_ete = attr if type_check(attr, String)
  end

  def filed_time=(attr)
    @filed_time = attr if type_check(attr, Integer)
  end

  def filed_departuretime=(attr)
    @filed_departure_time = date_from_epoch(attr) if type_check(attr, Integer)
  end

  def filed_airspeed_kts=(attr)
    @filed_airspeed_kts = attr if type_check(attr, Integer)
  end

  def filed_airspeed_mach=(attr)
    @filed_airspeed_mach = attr if type_check(attr, String)
  end

  def filed_altitude=(attr)
    @filed_altitude = attr if type_check(attr, Integer)
  end

  def route=(attr)
    @route = attr if type_check(attr, String)
  end

  def actualdeparturetime=(attr)
    @actual_departure_time = date_from_epoch(attr) if type_check(attr, Integer)
  end

  def estimatedarrivaltime=(attr)
    @estimated_arrival_time = date_from_epoch(attr) if type_check(attr, Integer)
  end

  def actualarrivaltime=(attr)
    @actual_arrival_time = date_from_epoch(attr) if type_check(attr, Integer)
  end

  def diverted=(attr)
    @diverted = attr if type_check(attr, String)
  end

  def origin=(attr)
    @origin_airport_code = attr if type_check(attr, String)
  end

  def destination=(attr)
    @destination_airport_code = attr if type_check(attr, String)
  end

  def originName=(attr)
    @origin_airport_name = attr if type_check(attr, String)
  end

  def originCity=(attr)
    @origin_city_name = attr if type_check(attr, String)
  end

  def destinationName=(attr)
    @destination_airport_name = attr if type_check(attr, String)
  end

  def destinationCity=(attr)
    @destination_city_name = attr if type_check(attr, String)
  end

  def to_flight_hash
    self.instance_values.select { |e| Flight.column_names.include? e }
  end

  private

    def type_check(attr, type)
      raise ArgumentError, "#{attr.inspect} is not #{type}" unless attr.is_a? type
      true
    end

    def date_from_epoch(i)
      if i
        i > 0 ? Time.at(i).utc : nil
      end
    end

end
