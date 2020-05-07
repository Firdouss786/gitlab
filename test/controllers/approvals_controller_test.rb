require 'test_helper'

class ApprovalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:chris)
    @pending_approval = approvals(:pending_approval)
  end

  test "should approve request" do
    assert @pending_approval.pending?

    patch approval_url @pending_approval
    assert_redirected_to notifications_url

    assert @pending_approval.reload.approved?
  end

  test "should reject approval" do
    assert_difference('Approval.count', -1) do
      assert_difference('Access.count', -1) do
        delete approval_url @pending_approval
      end
    end

    assert_redirected_to notifications_url
  end
end
