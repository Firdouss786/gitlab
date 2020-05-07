module Activity::Expireable
  extend ActiveSupport::Concern

  included do
    after_create_commit :schedule_for_expiration
  end

  def expire!
    destroy if created?
  end

  private

    def schedule_for_expiration
      ExpireActivityJob.set(wait: 2.days).perform_later(self)
    end

end
