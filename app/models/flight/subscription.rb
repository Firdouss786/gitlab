class Flight::Subscription < ApplicationRecord

  belongs_to :aircraft, touch: true
  validates :aircraft, uniqueness: true
  enum state: { pending_subscription: 'pending_subscription', subscribed: 'subscribed', pending_deletion: 'pending_deletion', failed: 'failed' }

  after_create_commit :register

  def register
    RegisterFlightSubscriptionJob.perform_later self
  end

  def deregister
    DeregisterFlightSubscriptionJob.perform_later self
  end

end
