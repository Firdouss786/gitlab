module Fault::Resolvable
  extend ActiveSupport::Concern

  included do
    def resolve(resolving_action:)
      update state: :closed, resolving_corrective_action: resolving_action, resolved_at: Time.now
    end
  end

end
