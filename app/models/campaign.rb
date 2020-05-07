class Campaign < ApplicationRecord

  include Searchable

  belongs_to :task_template, touch: true

  attr_accessor :selected

  validates :scheduled_end, presence: true

  def completion_percentage
    if task_template.tasks.any?
      ( ( task_template.tasks.completed.count.to_f / task_template.tasks.count.to_f ) * 100 ).round(0)
    else
      return 0
    end
  end

  def searchable_attributes
    [id, self.task_template.name]
  end

end
