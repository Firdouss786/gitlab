require 'test_helper'

class CorrectiveActionDeletionPolicyTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:chris)

    @fault_with_corrective_actions = faults(:confirmed_on_ground)
  end

  test "fixture data is valid" do
    assert @fault_with_corrective_actions.closed?
    assert_equal 2, @fault_with_corrective_actions.corrective_actions.count
  end

  test "cannot delete a corrective action unless it's the latest" do
    assert_no_difference "CorrectiveAction.count" do
      @fault_with_corrective_actions.corrective_actions.first.destroy
    end
  end

  test "can delete the latest corrective action" do
    assert_difference "CorrectiveAction.count", -1 do
      @fault_with_corrective_actions.corrective_actions.last.destroy
    end
  end

  test "if fault was not a deferral, just reopen it (the user will have to set the fault resolution again)" do
    @fault_with_corrective_actions.corrective_actions.last.destroy

    assert @fault_with_corrective_actions.active?
    assert_nil @fault_with_corrective_actions.resolving_corrective_action
    assert_nil @fault_with_corrective_actions.resolved_at
  end
end
