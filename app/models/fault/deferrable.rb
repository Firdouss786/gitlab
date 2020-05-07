module Fault::Deferrable
  extend ActiveSupport::Concern

  included do
    belongs_to :defer_reason, optional: true

    def defer(reason:, mel_category:)
      update deferral: true, defer_reason: reason, mel_cetegory: mel_category
    end

    def deferred?
      deferral
    end

    scope :deferred, -> { where(deferral: true) }
    scope :not_deferred, -> { where(deferral: false) }
  end

end
