namespace :flight do
  desc "Fetches all flights for all aircraft from the remote service API"
  task fetch_all: :environment do
    if FlightAware.authorized?
      [7, 170].each do |airline_id|
        airline = Airline.find(airline_id)

        puts ""
        puts "Fetching data for #{airline.name}"
        puts ""
        airline.aircrafts.each {|aircraft| FetchFlightDataJob.perform_now aircraft.id; print "." }
      end
    else
      puts "Unable to authorize with flight data service"
    end
  end

  desc "Subscribes all aircraft to flight data"
  task subscribe_all: :environment do
    if FlightAware.authorized?
      [7, 170, 507].each do |airline_id|
        airline = Airline.find(airline_id)

        puts ""
        puts "Subscribing all aircraft for #{airline.name}..."
        puts ""
        airline.aircrafts.each {|aircraft| aircraft.subscribe_flights; print "." }
      end
    else
      puts "Unable to authorize with flight data service"
    end
  end

  desc "UnSubscribes all aircraft to flight data"
  task unsubscribe_all: :environment do
    if FlightAware.authorized?
      [7, 170, 507].each do |airline_id|
        airline = Airline.find(airline_id)

        puts ""
        puts "Unsubscribing all aircraft for #{airline.name}..."
        puts ""
        airline.aircrafts.each {|aircraft| aircraft.unsubscribe_flights; print "." }
      end
    else
      puts "Unable to authorize with flight data service"
    end
  end

  desc "Setup Subscription Endpoint"
  task setup_subscription: :environment do
    if FlightAware.authorized?
      FlightAware.register_endpoint_with_flight_service
    else
      puts "Unable to authorize with flight data service"
    end
  end

  desc "Flush All FA Alerts"
  task flush_all_alerts: :environment do
    if FlightAware.authorized?
      FlightAware.flush_all_alerts
    else
      puts "Unable to authorize with flight data service"
    end
  end

  desc "Download subscription table from staging"
  task import_subscriptions: :environment do
    exec "mysqldump -u root -p'#{Rails.application.credentials.firefly_staging_database_password}' -h firefly-staging.cqp2xwflcgyi.eu-west-2.rds.amazonaws.com firefly_staging flight_subscriptions > tmp/flight_subscriptions.sql && mysql -u root firefly_development < tmp/flight_subscriptions.sql"
  end

end
