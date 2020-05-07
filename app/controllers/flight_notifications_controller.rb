class FlightNotificationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_authorize_resource

  def create
    REDIS_COUNTER.incr "counter:flight:notification:#{Time.now.strftime('%Y-%m-%d-%H')}"

    if flight_data_enabled?
     @subscription = Flight::Subscription.find_by(vendor_subscription_id: vendor_subscription_id)

      if @subscription.present?
       FetchFlightDataJob.perform_later(@subscription.aircraft)
      end

      head :ok
    end
  end

  private

    def vendor_subscription_id
      Flight::Adapters::FlightAware::WebhookParams.new(params).call
    end

    def flight_data_enabled?
      FeatureFlag.get?('flight_data')
    end

end
