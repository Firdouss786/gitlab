require 'test_helper'

class FaultResolutionsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in_as users(:chris)
    @activity = activities(:open_wp)
    @fault = Fault::Logbook.find(faults(:fault_actioned_and_raised_in_wp).id)
    @fault_ca = corrective_actions(:ca_actioned_and_raised_in_wp)
    @deferral = Fault::Logbook.find(faults(:fault_deferral).id)
    @deferral_ca = corrective_actions(:ca_actioned_for_deferral)
  end

  test "should get edit" do
    get edit_activity_fault_resolutions_path(@activity, fault_id: @fault.id)
    assert_response :success
  end

  test "should close fault if in active state and vice versa" do
    patch activity_fault_resolutions_path(@activity, fault_id: @fault.id), params: { fault_resolution: { state: 'true', resolving_corrective_action_id: @fault_ca.id } }
    assert_redirected_to [@activity, @fault.becomes(Fault)]

    @fault.reload
    assert @fault.closed?
    assert @fault.resolving_corrective_action == @fault_ca

    patch activity_fault_resolutions_path(@activity, fault_id: @fault.id), params: { fault_resolution: { state: 'false' } }
    assert_redirected_to [@activity, @fault.becomes(Fault)]

    @fault.reload
    assert @fault.active?
    assert_nil @fault.resolving_corrective_action
  end

  test "when fault resolution is true, fault should resolve. When false, fault should activate" do
    patch activity_fault_resolutions_path(@activity, fault_id: @deferral.id), params: { fault_resolution: { state: 'true', resolving_corrective_action_id: @deferral_ca.id } }
    assert_redirected_to [@activity, @deferral.becomes(Fault)]

    @deferral.reload
    assert @deferral.closed?
    assert @deferral.resolving_corrective_action == @deferral_ca

    patch activity_fault_resolutions_path(@activity, fault_id: @deferral.id), params: { fault_resolution: { state: 'false' } }
    assert_redirected_to [@activity, @deferral.becomes(Fault)]

    @deferral.reload
    assert @deferral.active?
    assert_nil @deferral.resolving_corrective_action
  end

  test "cannot update fault if current activity is in complete or error state" do
    @activity = activities(:closed_wp)
    patch activity_fault_resolutions_path(@activity, fault_id: @fault.id), params: { fault_resolution: { state: 'true', resolving_corrective_action_id: @fault_ca.id } }
    assert_select "[data-test-id='error_explanation']", "cannot update fault status, activity is in complete state."
  end

end
