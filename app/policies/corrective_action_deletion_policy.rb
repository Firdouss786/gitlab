class CorrectiveActionDeletionPolicy
  include ActiveModel::Model
  attr_reader :corrective_action

  validate :is_latest_corrective_action

  def initialize(corrective_action)
    @corrective_action = corrective_action
    @fault = @corrective_action.fault
  end

  def call
    return false if invalid?

    reopen_fault
    # restore_deferral if @fault.deferral

    true
  end

  private

    def reopen_fault
      @fault.reopen
    end

    # def restore_deferral
    #   @fault.defer reason: @fault.last_deferral[-2].try(:defer_reason)
    # end

    def is_latest_corrective_action
      if @corrective_action != @fault.corrective_actions.last
        errors.add(:base, "can only delete the latest corrective action")
      end
    end

end
