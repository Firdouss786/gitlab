# Flight Adapter
## Overview
Flight data is consumed from a third-party service called FlightAware. The API is RESTful JSON, and the docs can be found [here](https://flightaware.com/commercial/flightxml/documentation2.rvt)

We are currently using version 2 of the API, there is a version 3 but it is currently in closed BETA.

From testing, we found that not all of our customers have scheduled data (forward looking flights) available, as apparently those are the only airlines that provide it to FlightAware. These are:
 - American Airlines
 - Air India Limited
 - Air Canada
 - British Airways
 - Korean Air
 - South African Airways
 - Saudi Arabian Airlines
 - Gulf Air
 - Qatar

 Airlines (for testing) that confirmed do not have future flights:
  - Oman Airways
  - Etihad

### Summary of source files involved in the flight data process
 - `config/initializers/set_flight_aware_constants.rb` - There are some global variables located here as settings for the Flight Aware API
 - `app/models/flight.rb` - This is the flight model, where the parsed flights eventually gets stored
 - `app/models/concerns/aircraft_status_observable.rb` - This is a concern mixed-in to the flight model, it is invoked every time a flight is added, and handles the creation or updating of the `Aircraft::Status`
 - `app/models/aircraft/status.rb` - This aircraft status links each aircraft to its 'latest' flight
 - `app/controllers/flight_notifications_controller.rb` - This controller receives incoming messages from the Flight Aware API
 - `app/services/flight_aware.rb` - This is the service which makes HTTP calls to the Flight Aware API. It also contains the method to parse a JSON flight
 - `app/models/concerns/flight_subscribable.rb` - This is a concern mixed-in to the `Aircraft` model. Its job is to register each aircraft with the Flight Aware Push Notifications API


### Aircraft / Flight Subscription
Each aircraft should have a `Flight::Subscription`. This is just a model which associates the aircraft with an `alert_id`. Alert ID's are provided by the Flight Aware API when an aircraft is registered, you can think of it as an external vendor ID. Whenever we receive messages from Flight Aware, we look up the alert ID so we know which aircraft in our database they are talking about.

### Auto Subscription
As per the `FlightSubscribable` concern, after an Aircraft has been created, it will automatically be subscribed via a callback.


### Changes for deregistering the subscription

- Created a Deregistration adapter class called `Flight::Adapters::FlightAware::Deregistration`.

    - Responsible to contact the API and sends back the response
    - initialized with the subscription object
    - `deregister` method is responsible to contact the flight aware api and upon success returns the api response.

- Created a new Plain Ruby class `Flight::Deregistration`

    - When initialized will load the flight_subscription object from the params
    -  `deregister` method will do the deregistration process.
    - `begin_deregistration` method is responsible to check whether the subscription object is already subscribed or not using the `subscribed?` method. If not will raise an error
    - `call_adapter` method will call the newly created Deregistration adapter which internally connects with the FlightAware API. If the deregistration process is success then it will delete the subscription object and deletes from the database.

### Deregistration Flow

- Deregistration flow starts with the airlines subscriptions list.
- The process is initiated with all subscribed alerts.
- When the user clicked `Unsubscribe` button from the page, the flow will come to the controller
- Loading the subscription instance and calling the `deregister` method of the instance.
- This will make the background job to deregister the alert using the `Flight::Deregistration` class.
- Responding back with the deregistration scheduled message to the view.
- Backgroud job is being processed with the adapter `Flight::Adapters::FlightAware::Deregistration`
- when the API response is success, then deleting the record from the database. And this will be updated on the view also.


### Auto creation of Airports
Since the number of airports grows over time, we sometimes get messages from Flight Aware about airports we don't know about. Luckily, the Flight Aware API has an endpoint for getting airport information. When a new Airport is created in our database, a call is automatically made to fetch this information from flight aware – see `app/models/airport.rb`.

### Aircraft Status
So the Flights table holds all of the current and historical flights, but there is also another table which links each aircraft to the most current flight, be that in-flight or arrived. This model is here - `app/models/aircraft/status.rb`. This is used by the views to get all of the current flights.

This could have been a field on the aircraft table, but it will be frequently updated. It's best to separate concepts which update at different velocities to avoid invalidating caches.

### Flight Webhook
Since we have all the aircraft subscribed to Flight Aware, they will send us new flights and updated flights as they happen. These messages will land at our `POST /flight_notifications` endpoint. The `FlightNotificationsController` then uses our custom `FlighAware` service (`app/services/flight_aware.rb`) to parse the message, and save it to the database.

However, there is one type of message we don't seem to get to the webbook – future scheduled flights. This is where we have to reach out to them and proactively grab them...

### Getting Future Flights
Flight Aware have an endpoint called [FlightInfoEx](http://flightxml.flightaware.com/soap/FlightXML2/doc#op_FlightInfoEx). By passing an aircraft tail to it ie `POST http://flightxml.flightaware.com/json/FlightXML2/FlightInfoEx?ident=N904AA`, we get back an array of objects, both current and future flights.

When a flight arrives at the `FlightNotificationsController`, it is parsed and saved to the database. A background job (`FetchFlightDataJob`) is then kicked off to fetch all present and future flights from the `FlightInfoEx` API. Since we already have the present flights, we only save them if the flight is `scheduled` AKA future.
