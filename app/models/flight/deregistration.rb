class Flight::Deregistration

  def initialize(subscription)
    @subscription = subscription
    @deregistered = false
  end

  def deregister
    begin_deregistration
    call_adapter
    destroy_subscription if @deregistered
  end

  private

    def begin_deregistration
      raise StandardError, 'Error:: Not Subscribed yet' unless subscribed?
    end

    def subscribed?
      @subscription.subscribed? && @subscription.vendor_subscription_id.present?
    end

    def call_adapter
      @deregistered = deregistration_adapter.new(@subscription).deregister
    end

    def destroy_subscription
      @subscription.destroy
    end

    def deregistration_adapter
      Flight::Adapters::FlightAware::Deregistration
    end

end
