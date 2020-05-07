module FlightSubscribable
  extend ActiveSupport::Concern

  included do
    has_one :flight_subscription, class_name: "Flight::Subscription"

    after_create :subscribe_flights

    def subscribe_flights
      create_flight_subscription! unless flight_subscription
    end

    def unsubscribe_flights
      flight_subscription.destroy if flight_subscription
    end
  end
end
