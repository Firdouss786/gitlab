class TaskAction < ApplicationRecord

  after_save :update_task, if: -> { saved_change_to_completion_percentage? }
  before_destroy :revert_task

  belongs_to :created_by, class_name: "User", default: -> { Current.user }
  belongs_to :user, optional: true, default: -> { Current.user } # not using this
  belongs_to :activity
  belongs_to :task

  has_many :task_actions_users, dependent: :destroy
  has_many :users, through: :task_actions_users

  validates :completed_at, :completion_percentage, :users, presence: true
  validates :completion_percentage, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, if: -> { completion_percentage? }
  validate :task_percentage, if: -> { task_id? && completion_percentage? }
  validate :task_state, on: :create, if: -> { task_id? }
  validate :activity_state, :logged_in_user, if: -> { activity_id? }
  validate :performed_by_users, if: -> { activity_id? && users.present? }

  scope :chronilogical, -> { order(:completed_at) }

  private

    def task_state
      errors.add(:base, "cannot add new task action, task is in #{task.state} state") if task.completed? || task.erroneous?
    end

    def performed_by_users
      errors.add(:base, "performed by users must be active in current workpack station") if (users.ids - activity.station.users.unlocked.ids).present?
    end

    def activity_state
      errors.add(:base, "cannot add/update task action for workpack in complete/error state") if activity.complete? || activity.error?
    end

    def logged_in_user
      errors.add(:base, "logged-in user is not authorized to work under this station") unless Current.user.stations.include?(activity.station)
      errors.add(:base, "logged-in user is not authorized to work for this aircraft/airline") unless Current.user.airlines.include?(activity.aircraft.airline)
    end

    def task_percentage
      errors.add(:completion_percentage, "exceeds 100%") if total_task_completion_percentage > 100
    end

    def total_task_completion_percentage
      total_task_percentage = task.completion_percentage + completion_percentage
      total_task_percentage -= completion_percentage_was if persisted?
      total_task_percentage
    end

    def update_task
      total_task_percentage = task.completion_percentage + completion_percentage
      percentage_was = saved_change_to_completion_percentage.first
      total_task_percentage -= percentage_was if percentage_was

      if total_task_percentage == 100
        task_params = { completion_percentage: 100, state: 'completed', completed_in_activity: activity, completed_at: Time.now }
      else
        task_params = { completion_percentage: total_task_percentage, state: 'active', completed_in_activity: nil, completed_at: nil }
      end

      task.update(task_params)
    end

    def revert_task
      task.update(completion_percentage: task.completion_percentage - completion_percentage, state: 'active', completed_in_activity: nil, completed_at: nil)
    end

end
