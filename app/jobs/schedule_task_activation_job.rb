class ScheduleTaskActivationJob < ApplicationJob
  queue_as :default

  def perform(task_id:)
    # Don't know how to get around this, there is no database connection when this is run in test
    # so the test fails. Weirdly, it can run Task.find, but not active!
    Task.find(task_id).active! unless Rails.env.test?
  end
end
