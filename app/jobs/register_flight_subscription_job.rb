class RegisterFlightSubscriptionJob < ApplicationJob
  queue_as :default

  def perform(subscription)
    Flight::Registration.new(subscription).register
  end
end
