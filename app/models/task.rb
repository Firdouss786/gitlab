class Task < ApplicationRecord

  after_save :set_state_to_active, if: -> { created? && started_in_activity_id? }
  after_save :respawn_task, if: -> { completed? }

  belongs_to :created_by, class_name: "User", default: -> { Current.user } # not using this for anything
  belongs_to :user, default: -> { Current.user }
  belongs_to :aircraft, touch: true
  belongs_to :task_template
  belongs_to :started_in_activity, class_name: "Activity", touch: true, optional: true
  belongs_to :completed_in_activity, class_name: "Activity", touch: true, optional: true
  has_many :task_actions

  enum state: { created: 'created', active: 'active', completed: 'completed', erroneous: 'erroneous' }

  scope :eligible_for_work, -> { where(state: ['created', 'active']) }
  scope :desc, -> { order(created_at: :desc) }

  validates_presence_of :started_at
  validates :completion_percentage, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, if: -> { completion_percentage? }
  validates :logbook_reference, uniqueness: { case_sensitive: false }, if: -> { logbook_reference? }
  validate :scheduled_task_template, on: :update
  validate :activity_state, if: -> { started_in_activity_id? && not_in_allowed_params? }
  validate :logged_in_user, if: -> { started_in_activity_id? }

  def last_task_action
    task_actions.order(:completed_at).last
  end

  def name
    task_template.name
  end

  def scheduled_task?
    self.due_at.present?
  end

  def respawn_task
    RespawnTaskService.new(self).call
  end

  private

    def set_state_to_active
      self.active!
    end

    def fleet_templates
      aircraft.fleet.task_templates.where(archival: nil)
    end

    def activity_state
      errors.add(:base, "cannot add/update task for workpack in complete/error state") if ['complete', 'error'].include?(started_in_activity.state)
    end

    def scheduled_task_template
      errors.add(:task_template, "cannot change task template of scheduled task") if task_template_id_changed? && self.scheduled_task?
    end

    def not_in_allowed_params?
      !(state_changed? || completion_percentage_changed? || completed_in_activity_id_changed? || completed_at_changed?)
    end

    def logged_in_user
      errors.add(:base, "logged-in user is not authorized to work under this station") unless Current.user.stations.include?(started_in_activity.station)
      errors.add(:base, "logged-in user is not authorized to work for this aircraft/airline") unless Current.user.airlines.include?(started_in_activity.aircraft.airline)
    end

end
