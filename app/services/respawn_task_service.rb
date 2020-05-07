class RespawnTaskService
  include ActiveModel::Model

  attr_accessor :task

  validates_presence_of :task
  validate :task_should_recur

  def initialize(task)
    @task = task
  end

  def call
    return false if invalid?
    respawn_task
  end

  private

    def respawn_task
      BuildTaskService.new({
        template: @task.task_template,
        aircraft: @task.aircraft,
        options: {due_at: due_date}}
      ).call.save
    end

    def task_should_recur
      errors[:base] << "This task does not recur" unless @task.task_template.recurring?
    end

    def due_date
      # @completion_date.to_date + @task.task_template.repeat_interval.days
      @task.completed_at.to_date + @task.task_template.repeat_interval.days
    end

end
