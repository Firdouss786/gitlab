require 'test_helper'

# These are faults within the context of an Activity. We may namepsace these controllers later on.
class FaultsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in_as users(:chris)

    @airline = airlines(:baw)
    @activity = activities(:open_wp)
    @fault = faults(:fault_opened_in_wp)
  end

  test "index" do
    # Index test covered by ActivityController
  end

  test "show" do
    get activity_fault_path(@activity, @fault)

    assert_response :success
  end

  test "new" do
    get new_activity_fault_path(@activity)

    assert_response :success
  end

  test "clone" do
    get clone_activity_fault_path(@activity, @fault)

    assert_select "#fault_logbook_reference[value=?]", @fault.logbook_reference
    assert_select "input[value=?]", "Create Fault"
  end

  test "edit" do
    get edit_activity_fault_path(@activity, @fault)

    assert_response :success
  end

  test "create" do
    assert_difference('Fault.count') do
      post activity_faults_url(@activity), params: {  fault: { raised_at: @fault.raised_at, recorded_by_id: @fault.recorded_by.id, seats_impacted: "1A, 1E", logbook_reference: "E108569/UNIQUE", logbook_text: @fault.logbook_text, discrepancy_id: @fault.discrepancy.id, discovered: @fault.discovered, confirmed: @fault.confirmed, inbound_deferred: @fault.inbound_deferred, cid: @fault.cid} }
    end

    assert_redirected_to [@activity, Fault.last]
  end

  test "update" do
    patch activity_fault_path(@activity, @fault), params: { fault: { raised_at: @fault.raised_at + 10.minutes } }

    assert_redirected_to [@activity, @fault]
  end

  test "should destroy fault" do
  #   assert_difference('Fault.count', -1) do
  #     delete fault_url(@fault)
  #   end
  #
  #   assert_redirected_to faults_url
  end


  # Features
  test "can't edit fault outside of originating activity" do
    activity = activities(:closed_wp)

    patch activity_fault_path(activity, @fault), params: { fault: { raised_at: @fault.raised_at } }

    assert_select "[data-test-id='error_explanation']", text: 'cannot edit fault outside its originating activity.'
  end

end
