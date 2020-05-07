class Flight::Adapters::FlightAware::AirportInfo
  include ActiveModel::Model

  attr_reader :name, :latitude, :longitude, :timezone, :city

  # SETTERS

  def name=(attr)
    @name = attr
  end

  def latitude=(attr)
    @latitude = attr
  end

  def longitude=(attr)
    @longitude = attr
  end

  def timezone=(attr)
    @timezone = attr
  end

  def location=(attr)
    @city = attr
  end

end
