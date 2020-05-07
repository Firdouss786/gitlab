class DeferralAction
  include ActiveModel::Model

  attr_accessor :activity_id, :fault_id, :job_started_at, :performed_by_id, :maintenance_action_id, :logbook_text, :document_reference, :opdef, :defer_reason_id, :product_id, :mel_category

  validates_presence_of :fault_id, :job_started_at, :performed_by_id, :maintenance_action_id, :logbook_text, :document_reference, :opdef, :defer_reason_id, :mel_category

  def self.find(id)
    CorrectiveAction.find(id)
  end

  def save
    deferral_action_serialized = self.as_json
    return false if invalid?

    CorrectiveAction.new(deferral_action_serialized).save
  end

end
