require 'sinatra/base'

class FakeFlightAware < Sinatra::Base

  get '/json/FlightXML2/SetAlert' do
    content_type :json
    { "SetAlertResult": 29302688 }.to_json
  end

  get '/json/FlightXML2/DeleteAlert' do
    content_type :json
    { "DeleteAlertResult": 1 }.to_json
  end

  get '/json/FlightXML2/AirportInfo' do
    content_type :json

    if params["airportCode"] == "ULLI"
      return {"AirportInfoResult":{"name":"Pulkovo","location":"Saint Petersburg","longitude":30.262503,"latitude":59.800292,"timezone":":Europe/Moscow"}}.to_json
    end

    if params["airportCode"] == "KCLT"
      return {"AirportInfoResult":{"name":"Charlotte/Douglas Intl","location":"Charlotte, NC","longitude":-80.9490556,"latitude":35.21375,"timezone":":America/New_York"}}.to_json
    end

    if params["airportCode"] == "AYGA"
      return {"AirportInfoResult":{"name":"Goroka","location":"Goroka","longitude":145.391881,"latitude":-6.081689,"timezone":":Pacific/Port_Moresby"}}.to_json
    end

    if params["airportCode"] == "AYGA"
      return {"error"=>"NO_DATA unknown airport LANP"}.to_json
    end

  end

  get '/json/FlightXML2/FlightInfoEx' do
    content_type :json

    if params["ident"] == "gstbc"
      return {"FlightInfoExResult":{"next_offset":-1,"flights":[
        {"faFlightID":"BAW247-1581054333-airline-0045","ident":"BAW247","aircrafttype":"777","filed_ete":"11:40:00","filed_time":1.days.ago.to_i,"filed_departuretime":1.days.ago.to_i,"filed_airspeed_kts":439,"filed_airspeed_mach":"","filed_altitude":0,"route":"","actualdeparturetime":0,"estimatedarrivaltime":Time.now.to_i,"actualarrivaltime":0,"diverted":"","origin":"EGLL","destination":"SBGR","originName":"London Heathrow","originCity":"London, England","destinationName":"São Paulo-Guarulhos Int'l","destinationCity":"Sao Paulo"},
        {"faFlightID":"BAW461-1580881537-airline-0108","ident":"BAW461","aircrafttype":"777","filed_ete":"01:44:00","filed_time":6.days.ago.to_i,"filed_departuretime":6.days.ago.to_i,"filed_airspeed_kts":337,"filed_airspeed_mach":"","filed_altitude":0,"route":"","actualdeparturetime":6.days.ago.to_i,"estimatedarrivaltime":5.days.ago.to_i,"actualarrivaltime":5.days.ago.to_i,"diverted":"","origin":"LEMD","destination":"EGLL","originName":"Barajas Int'l","originCity":"Madrid","destinationName":"London Heathrow","destinationCity":"London, England"},
        {"faFlightID":"BAW460-1580881535-airline-0133","ident":"BAW460","aircrafttype":"777","filed_ete":"02:10:00","filed_time":3.days.ago.to_i,"filed_departuretime":3.days.ago.to_i,"filed_airspeed_kts":337,"filed_airspeed_mach":"","filed_altitude":0,"route":"","actualdeparturetime":3.days.ago.to_i,"estimatedarrivaltime":2.days.ago.to_i,"actualarrivaltime":2.days.ago.to_i,"diverted":"","origin":"EGLL","destination":"LEMD","originName":"London Heathrow","originCity":"London, England","destinationName":"Barajas Int'l","destinationCity":"Madrid"}]}}.to_json
    end

    if params["ident"] == "N70020"
      return {}.to_json
    end

  end

  get '/json/FlightXML2/RegisterAlertEndpoint' do
    content_type :json

      if ENV["REQUEST"] == "successful"
        return {"RegisterAlertEndpointResult":1}.to_json
      else
       ENV["REQUEST"] = "successful"
       return {"RegisterAlertEndpointResult":0}.to_json
      end
  end

end
