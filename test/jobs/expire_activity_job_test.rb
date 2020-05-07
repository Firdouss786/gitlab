require 'test_helper'

class ExpireActivityJobTest < ActiveJob::TestCase

  test "enque expiration job when activity is created" do
    assert_enqueued_with(job: ExpireActivityJob) do
      activities(:created_empty).dup.save
    end
  end

end
