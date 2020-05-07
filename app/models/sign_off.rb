class SignOff

  # require "net/http"
  # require "uri"

  include ActiveModel::Model

  attr_accessor :activity, :boarded_at, :unboarded_at

  validates_presence_of :activity, :boarded_at, :unboarded_at
  validate :logged_in_user, :activity_state, if: -> { activity.present? }
  validate :boarding_unboading_time, if: -> { boarded_at.present? && unboarded_at.present? }
  validate :validate_deferrals_state, :validate_logbook_state, :validate_tasks_state, if: -> { activity.present? }

  def process
    if valid?
      update_activity
      set_state_to_complete
      # send_gmm
      # send_to_sap
      true
    end
  end

  private

    def logged_in_user
      errors.add(:closed_by, "logged-in user is not authorized to close workpack under this station") unless Current.user.stations.include? @activity.station
      errors.add(:closed_by, "logged-in user is not authorized to close workpack for this airline") unless Current.user.airlines.include? @activity.aircraft.airline
    end

    def activity_state
      errors.add(:base, "can not close workpack from #{@activity.state} state.") if ['complete', 'error'].include? @activity.state
    end

    def boarding_unboading_time
      boarded_at_limit = @activity.corrective_actions.minimum(:job_started_at)
      if boarded_at_limit.present?
        errors.add(:boarded_at, "must be before any corrective actions of this activity") unless @boarded_at <= boarded_at_limit  
      end
      errors.add(:unboarded_at, "must be after boarding time") unless @unboarded_at > @boarded_at
    end

    def update_activity
      @activity.update(boarded_at: @boarded_at, unboarded_at: @unboarded_at, closed_by: Current.user, closed_at: Time.now)
    end

    def validate_deferrals_state
      open_deferrals = Fault.where(aircraft: @activity.aircraft).where.not(activity: @activity).deferred
      unattended = open_deferrals.select { |d| d.last_deferral.activity != @activity }
      errors.add(:base, "cannot close workpack, #{unattended.map { |u| u.id } } deferral id(s) are still unattended") if unattended.present?
    end

    def validate_tasks_state
      active_tasks = Task.where(aircraft: @activity.aircraft).active
      unattended = active_tasks.select { |t| t.last_task_action.try(:activity) != @activity }
      errors.add(:base, "cannot close workpack, #{unattended.pluck(:id)} task id(s) are not yet completed") if unattended.present?
    end

    def validate_logbook_state
      unattended = @activity.faults.active
      errors.add(:base, "cannot close workpack, #{unattended.ids} logbook id(s) are still in active state") if unattended.present?
    end

    def set_state_to_complete
      @activity.complete!
    end

    def send_gmm
      # work on this when gmm side is ready
    end

    def send_to_sap
      replaced_lru = MaintenanceAction.find_by_name("replaced lru".upcase)
      lru_corrective_actions = activity.corrective_actions.where(maintenance_action: replaced_lru)

      if (lru_corrective_actions.present?)
        last_lru = lru_corrective_actions.last
        aircraft = last_lru.activity.aircraft.tail
        icao_code = last_lru.activity.aircraft.airline.icao_code
        removed_product = last_lru.replacement.removed_product.part_number
        removed_stock_item = last_lru.replacement.removed_stock_item.serial_number
        installed_product = last_lru.replacement.installed_product.part_number
        installed_stock_item = last_lru.replacement.installed_stock_item.serial_number

        params = { aircraft: aircraft, icao_code: icao_code, removed_product: removed_product, removed_stock_item: removed_stock_item, installed_product: installed_product, installed_stock_item: installed_stock_item }

        uri = URI("http://bf23e90e.ngrok.io/pushparttx")
        req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
        req.body = params.to_json
        res = Net::HTTP.start(uri.hostname, uri.port) { |http| http.request(req) }
        puts "SAP RESPONSE: #{res.code}"
      end

    end

end
