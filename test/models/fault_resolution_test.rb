require 'test_helper'

class FaultResolutionTest < ActiveSupport::TestCase

  setup do
    Current.user = users(:chris)
    @fault = Fault::Logbook.find(faults(:fault_actioned_and_raised_in_wp).id)
    @fault_ca = corrective_actions(:ca_actioned_and_raised_in_wp)

    @deferred_fault = Fault::Logbook.find(faults(:fault_deferral).id)
    @deferred_fault_ca = corrective_actions(:ca_other_in_wp_deferral)
  end

  test "fault attributes are reverted if state changed to active/deferred from closed/deferral_closed" do
    @fault.update(state: 'closed', resolving_corrective_action: @fault_ca)
    assert @fault.closed?
    assert @fault.resolving_corrective_action == @fault_ca

    @fault.active!

    assert @fault.active?
    assert_nil @fault.resolving_corrective_action
  end

end
