require 'test_helper'

class AccessTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  test "should not allow two accesses for the same user and airline" do
    assert Access.new(user: users(:chris), accessible: airlines(:baw)).invalid?
  end

  test "should allow multiple users to access the same airline" do
    assert Access.new(user: users(:maaz), accessible: airlines(:baw)).valid?
  end

  test "should allow one user to access multiple airlines" do
    assert Access.new(user: users(:chris), accessible: airlines(:jbu)).valid?
  end

  test "should enqueue email when approved" do
    approvals(:pending_approval).approved!

    assert_enqueued_emails 2
  end

  test "default status is enabled" do
    assert Access.new.enabled?
  end

  test "can disable access" do
    access = accesses(:enabled_access)
    access.disabled!

    assert access.disabled?
  end

  test "created approval should be pending" do
    assert_difference('Approval.count') do
      Approval.create approvable: accesses(:chris_access_to_aal), requestee: users(:chris)
    end

    assert Approval.last.pending?
  end

  test "should only get unlocked users" do
    assert_equal 2, approvals(:pending_approval).users.count
  end

  test "approving should change status" do
    approval = approvals(:pending_approval)

    approval.approved!

    assert approval.approved?
    assert approval.approvable.enabled?
  end

  test "touching approval should not change status" do
    approval = approvals(:pending_approval)

    assert approval.pending?
    assert approval.approvable.enabled?

    approval.touch

    assert approval.pending?
    assert approval.approvable.enabled?
  end
end
