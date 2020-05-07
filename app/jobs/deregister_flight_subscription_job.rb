class DeregisterFlightSubscriptionJob < ApplicationJob
  queue_as :default

  def perform(subscription)
    Flight::Deregistration.new(subscription).deregister
  end
  
end
