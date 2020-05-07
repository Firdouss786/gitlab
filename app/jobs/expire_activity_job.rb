class ExpireActivityJob < ApplicationJob
  queue_as :default

  # Activity may have been deleted before this job can run (ie manually)
  discard_on ActiveJob::DeserializationError

  def perform(activity)
    activity.expire!
  end
end
