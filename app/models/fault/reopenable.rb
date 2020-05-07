module Fault::Reopenable
  extend ActiveSupport::Concern

  included do
    def reopen
      update state: :active, resolving_corrective_action_id: nil, resolved_at: nil
    end
  end

end
