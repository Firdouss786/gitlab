class CorrectiveAction < ApplicationRecord

  after_save :update_fault_attributes, if: -> { deferral? }
  after_save :remove_unnecessary_params, if: -> { deferral? && defer_reason.name != 'no parts'.upcase && product_id? }

  before_destroy do
    throw(:abort) unless CorrectiveActionDeletionPolicy.new(self).call
  end

  belongs_to :user, default: -> { Current.user }
  belongs_to :performed_by, class_name: "User"
  belongs_to :fault, touch: true
  belongs_to :activity
  belongs_to :maintenance_action
  belongs_to :defer_reason, optional: true
  belongs_to :product, optional: true
  belongs_to :replacement, optional: true, dependent: :destroy
  accepts_nested_attributes_for :replacement, reject_if: :not_consumable_or_rotable

  scope :no_defers, -> { where.not(maintenance_action: MaintenanceAction.find_by_name('defer'.upcase)) }
  scope :defers, -> { where(maintenance_action: MaintenanceAction.find_by_name('defer'.upcase)) }
  scope :replaced_lru, -> { where(maintenance_action: MaintenanceAction.find_by_name('replaced lru'.upcase)) }
  scope :replaced_consumable, -> { where(maintenance_action: MaintenanceAction.find_by_name('replaced consumable'.upcase)) }
  scope :chronilogical, -> { order(:job_started_at) }

  validates :logbook_text, :document_reference, presence: true
  validates_presence_of :logbook_reference, unless: :deferral?
  validate :activity_state, if: -> { activity_id? }
  validate :fault_state, on: :create
  validate :logged_in_user, on: :update
  validate :activity_and_fault_aircraft, if: -> { activity_id? && fault_id? }
  validate :job_started_at_timmings
  validates :replacement, presence: true, unless: :not_consumable_or_rotable

  with_options unless: -> { !deferral? } do |d|
    d.validates :defer_reason, presence: true
    d.validates_inclusion_of :opdef, in: [true, false], message: "must be 'true' or 'false'"
    d.validates_presence_of :product, if: :no_part_deferral?
    d.validates_inclusion_of :product, in: :aircraft_bom, message: "must be a within BOM of selected aircraft", if: -> { product_id? }
  end

  def deferral?
    maintenance_action.name == 'defer'.upcase
  end

  def replaced_lru?
    maintenance_action.name == 'replaced lru'.upcase
  end

  def replaced_consumable?
    maintenance_action.name == 'replaced consumable'.upcase
  end

  private

    def logged_in_user
      if activity_id?
        errors.add(:base, "logged-in user is not authorized to work under this station") unless Current.user.stations.include?(activity.station)
        errors.add(:base, "logged-in user is not authorized to work for this aircraft/airline") unless Current.user.airlines.include?(activity.aircraft.airline)
      end
    end

    def not_consumable_or_rotable
      ["REPLACED CONSUMABLE", "REPLACED LRU"].exclude? maintenance_action.name
    end

    def job_started_at_timmings
      unless self.job_started_at.present? && self.job_started_at >= self.activity.boarded_at
        errors.add(:job_started_at, "can't be blank and can't be before #{self.activity.boarded_at}")
      end
    end

    def station_acceptable_users
      activity.station.users.unlocked
    end

    def fault_state
      errors.add(:base, "fault is closed, can't add new corrective action or deferral") if fault.closed?
    end

    def update_fault_attributes
      self.fault.defer reason: self.defer_reason, mel_category: self.fault.last_deferral.mel_category
    end

    def remove_unnecessary_params
      self.update(product_id: nil)
    end

    def no_part_deferral?
      defer_reason_id? && self.defer_reason.name == 'no parts'.upcase
    end

    def aircraft_bom
      self.activity.aircraft.bill_of_materials
    end

    def activity_and_fault_aircraft
      errors.add(:base, "aircraft for activity and fault is different.") unless activity.aircraft == fault.aircraft
    end

    def activity_state
      errors.add(:base, "Can't add/edit/delete correction action. Activity is in #{self.activity.state} state.") if activity.complete? || activity.error?
    end

end
