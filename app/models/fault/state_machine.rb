module Fault::StateMachine
  extend ActiveSupport::Concern

  included do
    enum state: { active: 'active'.upcase, deferred: 'defer'.upcase, closed: 'closed'.upcase, deferral_closed: 'defer_closed'.upcase, error: 'error' }

    validates :state, not_already_erroneous: true

    after_create :set_state_to_active

    def mark_as_erroneous
      set_state_to_error
    end
  end

  private
    def set_state_to_active
      active!
    end

    def set_state_to_error
      error!
    end
end
