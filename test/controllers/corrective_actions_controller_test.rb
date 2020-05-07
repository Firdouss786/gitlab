require 'test_helper'

class CorrectiveActionsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in_as users(:chris)
    @activity = activities(:open_wp)
    @fault = faults(:fault_opened_in_wp)
    @ca = corrective_actions(:system_reset)
  end

  test "should get new" do
    get new_activity_fault_corrective_action_path(@activity, @fault)
    assert_response :success
  end

  test "should create corrective_action" do
    assert_difference('CorrectiveAction.count') do
      post activity_fault_corrective_actions_path(@activity, @fault), params: { corrective_action: { job_started_at: Time.now, performed_by_id: @ca.performed_by_id, logbook_reference: @ca.logbook_reference, maintenance_action_id: @ca.maintenance_action_id, logbook_text: @ca.logbook_text, document_reference: @ca.document_reference } }
    end
    assert_redirected_to edit_activity_fault_resolutions_path(fault_id: CorrectiveAction.last.fault_id)
  end

  test "should create corrective_action with replaced_consumables" do
    @replace_consumable = replacements(:consumable_replacement)
    assert_difference('CorrectiveAction.count') do
      post activity_fault_corrective_actions_path(@activity, @fault), params: { corrective_action: { job_started_at: Time.now, performed_by_id: @ca.performed_by_id, logbook_reference: @ca.logbook_reference, maintenance_action_id: maintenance_actions(:replaced_consumable).id, logbook_text: @ca.logbook_text, document_reference: @ca.document_reference, replacement_attributes: { installed_product_id: @replace_consumable.installed_product_id, installed_stock_item_id: @replace_consumable.installed_stock_item_id, install_quantity: @replace_consumable.install_quantity} } }
    end

    assert_redirected_to edit_activity_fault_resolutions_path(fault_id: CorrectiveAction.last.fault_id)
  end

  test "should create corrective_action with replaced_rotable" do
    @replace_rotable = replacements(:rotable_replacement)
    assert_difference('CorrectiveAction.count') do
      post activity_fault_corrective_actions_path(@activity, @fault), params: { corrective_action: { job_started_at: Time.now, performed_by_id: @ca.performed_by_id, logbook_reference: @ca.logbook_reference, maintenance_action_id: maintenance_actions(:replaced_lru).id, logbook_text: @ca.logbook_text, document_reference: @ca.document_reference, replacement_attributes: { on_wing_position: @replace_rotable.on_wing_position, removed_product_id: @replace_rotable.removed_product_id, removed_stock_item_id: @replace_rotable.removed_stock_item_id, installed_product_id: @replace_rotable.installed_product_id, installed_stock_item_id: @replace_rotable.installed_stock_item_id, removal_reason_id: @replace_rotable.removal_reason_id } } }
    end

    assert_redirected_to edit_activity_fault_resolutions_path(fault_id: CorrectiveAction.last.fault_id)
  end

  test "should show corrective_action under activity" do
    get activity_fault_corrective_action_path(@activity, @fault, @ca)
    assert_response :success
  end

  test "corrective action show with replaced consumable" do
    @ca = corrective_actions(:consumable_replacement_two)
    get activity_fault_corrective_action_path(@activity, @fault, @ca)

    assert_response :success
    assert_select 'h2', 'Consumed Batch'
  end

  test "corrective action show with replaced_lru" do
    @ca = corrective_actions(:rotable_replacement_two)
    get activity_fault_corrective_action_path(@activity, @fault, @ca)

    assert_response :success
    assert_select 'h2', 'Removed Part'
  end

  test "should get edit under activity" do
    get edit_activity_fault_corrective_action_path(@activity, @fault, @ca)
    assert_response :success
  end

  test "should update corrective_action under activity" do
    patch activity_fault_corrective_action_path(@activity, @fault, @ca), params: { corrective_action: { logbook_reference: '12345/UNIQUE' } }
    edit_activity_fault_resolutions_path(fault_id: @ca.fault_id)
  end

  test "should destroy corrective_action" do
    @ca = corrective_actions(:ca_actioned_and_raised_in_wp)
    assert_difference('CorrectiveAction.count', -1) do
      delete activity_fault_corrective_action_path(@activity, @fault, @ca)
    end

    assert_redirected_to [@activity, @ca.fault]
  end
end
