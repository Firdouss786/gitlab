require 'test_helper'

class ScheduleTaskActivationJobTest < ActiveJob::TestCase
  test 'task is scheduled for activation' do
    assert_enqueued_with(job: ScheduleTaskActivationJob) do
      task = tasks(:recurring_with_completion)
      task.complete
    end

    # TODO: Traveling doesn't seem to work with ActiveJob, need to research more
    # travel_to Date.new(2018, 02, 12) do
    #   assert_equal "active", Task.last.state
    # end

  end
end
