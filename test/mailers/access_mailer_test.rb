require 'test_helper'

class AccessMailerTest < ActionMailer::TestCase
  test "notify_requestee_of_approved_access" do
    mail = AccessMailer.notify_requestee_of_approved_access(accesses(:chris_access_to_baw))
    assert_equal "You have been approved access to British Airways", mail.subject
    assert_equal ["chris.swann@thalesinflight.com"], mail.to
    assert_equal ["support@thalesinflight.com"], mail.from
  end

  test "notify_approvers_of_approved_access" do
    mail = AccessMailer.notify_approvers_of_approved_access(accesses(:chris_access_to_baw))
    assert_equal "Chris Swann has been approved access to British Airways", mail.subject
    assert_equal ["maaz.siddiqui@thalesinflight.com", "john.doe@thalesinflight.com"], mail.to
    assert_equal ["support@thalesinflight.com"], mail.from
  end
end
