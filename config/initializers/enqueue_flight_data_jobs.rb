# if Rails.env.production? || Rails.env.staging?
#   Airline.customers.each do |airline|
#     airline.aircrafts.each {|aircraft| FetchFlightDataJob.perform_later aircraft.id, reschedule: true }
#   end
# end
