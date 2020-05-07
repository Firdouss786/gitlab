class Fault::Logbook < Fault

  before_save :seats_impacted_format_and_count, if: -> { seats_impacted_changed? }
  before_save :remove_unnecessary_params
  after_save :remove_resolving_corrective_action, if: -> { resolving_corrective_action_id? && (active? || deferred?) }

  validates_presence_of :raised_at, :activity, :recorded_by, :discrepancy, :logbook_text
  validates :logbook_reference, presence: true, uniqueness: { case_sensitive: false }
  validate :check_activity_status, if: -> { changed? && activity_id? }
  validate :aircraft_same_in_activity, if: -> { aircraft_id? && activity_id? }

  validate :seats_impacted_in_lopa, if: -> { seats_impacted? && activity_id? }

  validate :aircraft_accessable_by_user, if: -> { aircraft_id? }
  validate :station_accessable_by_user, if: -> { activity_id? }

  validate :aircraft_accessable_by_recorded_by_user, if: -> { aircraft_id? && recorded_by_id? }
  validate :station_accessable_by_recorded_by_user, if: -> { recorded_by_id? && activity_id? }

  validate :logged_in_user, on: :update

  validates_inclusion_of :resolving_corrective_action, in: :corrective_actions_without_deferrals, message: "must be under same fault and can't be of type 'deferral'", if: -> { closed? || deferral_closed? }

  validates :discovered, presence: true, inclusion: { in: ["IN FLIGHT", "ON GROUND"], message: "can only be 'IN FLIGHT' or 'ON GROUND'" }
  validates_inclusion_of :cid, in: [true, false], message: "(Customer Induced Damage) can't be blank", if: Proc.new { |a| a.discovered == "ON GROUND" }

  with_options unless: Proc.new { |a| a.discovered != "IN FLIGHT" } do |d|
    d.validates_inclusion_of :confirmed, in: [true, false], message: "must be 'true' or 'false'"
    d.validates :action_carried, presence: true, if: Proc.new { |a| a.confirmed == false }
    d.validates_inclusion_of :cid, in: [true, false], message: "must be 'true' or 'false'", if: Proc.new { |a| a.confirmed == true }
    d.validates_inclusion_of :inbound_deferred, in: [true, false], message: "must be 'true' or 'false'"
    d.validates :deferral_reference, presence: true, if: Proc.new { |a| a.inbound_deferred == true }
  end

  private

    def aircraft_same_in_activity
      errors.add(:aircraft, "must be same as activity aircraft.") unless activity.aircraft == aircraft
    end

    def aircraft_accessable_by_user
      errors.add(:aircraft, "is not accessable by logged-in user.") unless user.airlines.include? aircraft.airline
    end

    def aircraft_accessable_by_recorded_by_user
      errors.add(:aircraft, "is not accessable by recorded_by user.") unless recorded_by.airlines.include? aircraft.airline
    end

    def station_accessable_by_user
      errors.add(:user, "logged-in is not allowed to add fault under #{activity.station.name} station.") unless activity.station.users.unlocked.include? user
    end

    def station_accessable_by_recorded_by_user
      errors.add(:recorded_by, "user is not allowed to add/edit fault under #{activity.station.name} station.") unless activity.station.users.unlocked.include? recorded_by
    end

    def check_activity_status
      errors.add(:base, "cannot add/edit fault, originating activity for this fault is in #{activity.state} state.") if ['complete', 'error'].include? activity.state
    end

    def seats_impacted_in_lopa
      selected_seats = seats_impacted.split(",").map(&:strip)
      seats_in_lopa = activity.aircraft.fleet.seats.pluck(:name)
      errors.add(:seats_impacted, "must be within LOPA and comma+space separated string not array i.e. '1A, 2B'") if (selected_seats - seats_in_lopa).present?
    end

    def seats_impacted_format_and_count
      if seats_impacted?
        self.seats_impacted = self.seats_impacted.split(",").map(&:strip).join(", ")
        self.impacted_seat_count = self.seats_impacted.split(",").length
      else
        self.impacted_seat_count = nil
      end
    end

    def corrective_actions_without_deferrals
      corrective_actions.no_defers
    end

    def logged_in_user
      errors.add(:base, "logged-in user is not authorized to work under this station") unless activity_id? && Current.user.stations.include?(activity.station)
      errors.add(:base, "logged-in user is not authorized to work for this aircraft/airline") unless aircraft_id? && Current.user.airlines.include?(aircraft.airline)
    end

    def remove_resolving_corrective_action
      self.update(resolving_corrective_action: nil)
    end

    def remove_unnecessary_params
      if self[:discovered] == 'ON GROUND'
        self[:raised_on_flight] = nil
        self[:confirmed] = false
        self[:action_carried] = nil
        self[:inbound_deferred] = false
        self[:deferral_reference] = nil
      else
        self[:cid] = false if self[:confirmed] == false
        self[:deferral_reference] = nil if self[:inbound_deferred] == false
      end
    end

end
