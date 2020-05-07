class Fault < ApplicationRecord
  include Deferrable, Reopenable, Resolvable, Searchable
      
  belongs_to :user, default: -> { Current.user }
  belongs_to :recorded_by, class_name: "User", optional: true
  belongs_to :aircraft

  # Optional associations are enforced by custom form objects in /fault
  belongs_to :discrepancy, optional: true
  belongs_to :activity, touch: true, optional: true

  belongs_to :resolving_corrective_action, class_name: "CorrectiveAction", optional: true
  has_many :corrective_actions

  enum action_carried: { Seat_reset_by_crew: "SEATRESET", System_reset_by_crew: "RESET", System_was_off_could_not_duplicate: "SYSTEMOFF", Functional_check_operational_check_satisfactory: "CHECKSATISFACTORY" }

  enum state: { active: 'active'.upcase, closed: 'closed'.upcase, error: 'error'.upcase }

  scope :active_or_closed, -> { where(state: ['active', 'closed']) }
  scope :defer_or_defer_closed, -> { where(state: ['deferred', 'deferral_closed']) }

  def deferral_closed?
    deferral && closed?
  end

  def last_deferral
    corrective_actions.defers.order(:created_at).last
  end

  def searchable_attributes
    [id, seats_impacted, logbook_reference, logbook_text, self.aircraft.tail, self.aircraft.airline.icao_code]
  end

end
