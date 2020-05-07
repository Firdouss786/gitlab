class Flight::Registration

  def initialize(subscription)
    @subscription = subscription
    @state = nil
    @vendor_subscription_id = nil
  end

  def register
    begin_registration
    call_adapter
    callback_subscription
  end

  private

    def begin_registration
      @subscription.pending_subscription!
    end

    def call_adapter
      vendor_subscription = registration_adapter.new(aircraft_tail).register

      @state = vendor_subscription[:registered] ? :subscribed : :failed
      @vendor_subscription_id = vendor_subscription[:subscription_id]
    end

    def callback_subscription
      @subscription.update(state: @state, vendor_subscription_id: @vendor_subscription_id)
    end

    def registration_adapter
      Flight::Adapters::FlightAware::Registration
    end

    def aircraft_tail
      @subscription.aircraft.sanitized_for_api
    end

end
