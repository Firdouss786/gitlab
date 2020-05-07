class BuildTaskService
  include ActiveModel::Model

  attr_accessor :template, :activity, :aircraft, :options

  validates_presence_of :template, :aircraft

  def call
    return nil unless valid?

    Task.new(task_construction_attributes).tap do |task|
      task.update @options if @options
      task.update started_in_activity: @activity if @activity
    end
  end

  private

    def task_construction_attributes
      {
        task_template: @template,
        aircraft: @aircraft,
        started_at: Time.now
      }
    end

end
