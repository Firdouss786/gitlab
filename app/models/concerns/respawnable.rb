module Respawnable
  extend ActiveSupport::Concern

  included do
    after_update :respawn, if: :completed?
  end

  private

    def respawn
      recreate_task_from_template if is_recurring?
    end

    def recreate_task_from_template
      task = Task.create \
        name: task_template.name,
        task_template: task_template,
        aircraft_id: aircraft_id,
        due_at: due_date

      # ScheduleTaskActivationJob.set(wait_until: task.due_at).perform_later(task_id: task.id)
    end

    def is_recurring?
      task_template.recurring?
    end

    def due_date
      completed_at.to_date + task_template.repeat_interval.days
    end
end
