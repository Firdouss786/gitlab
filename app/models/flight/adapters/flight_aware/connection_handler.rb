module Flight::Adapters::FlightAware::ConnectionHandler
  extend ActiveSupport::Concern

  included do
    def get(path)
      HTTParty.get(base_uri + path, options)
    end
  end

  private

    def base_uri
      "http://flightxml.flightaware.com/json/FlightXML2"
    end

    def options
      { headers: {authorization: "Basic #{Rails.application.credentials.fa_xml_key}"} }
    end

end
