require 'test_helper'

class AdjustmentsTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:chris)
    @activity = activities(:open_wp)
    @fault = faults(:fault_opened_in_wp)
    @ca = corrective_actions(:consumable_replacement_two)
    @replacement = replacements(:replacement_consumable_two)
  end

  test "should adjust stock when creating corrective action" do
    assert_equal 50, @replacement.installed_stock_item.quantity

    post activity_fault_corrective_actions_path(@activity, @fault), params: { corrective_action: { fault_id: @ca.fault.id, job_started_at: @ca.job_started_at, performed_by_id: @ca.performed_by_id, logbook_reference: @ca.logbook_reference, maintenance_action_id: @ca.maintenance_action_id, logbook_text: @ca.logbook_text, document_reference: @ca.document_reference, replacement_attributes: {installed_product_id: @replacement.installed_product_id, installed_stock_item_id: @replacement.installed_stock_item_id, install_quantity: 3} } }

    assert_equal Event.last.eventable.adjustable.id, Replacement.last.id
    assert_equal 47, @replacement.installed_stock_item.reload.quantity
  end

  test "should error previous adjustmets, and apply new one" do
    assert_equal 50, @replacement.installed_stock_item.quantity
    assert_equal 2, @replacement.adjustments.count

    patch activity_fault_corrective_action_path(@activity, @fault, @ca), params: { corrective_action: { job_started_at: @ca.job_started_at, performed_by_id: @ca.performed_by_id, logbook_reference: @ca.logbook_reference, maintenance_action_id: @ca.maintenance_action_id, logbook_text: @ca.logbook_text, document_reference: @ca.document_reference, replacement_attributes: {id: @replacement.id, installed_product_id: @replacement.installed_product_id, installed_stock_item_id: @replacement.installed_stock_item_id, install_quantity: 5}}}

    assert_equal 45, @replacement.installed_stock_item.reload.quantity
    assert_equal 3, @replacement.adjustments.count

    assert adjustments(:replacement_consumable_two_adjustment).error?
    assert adjustments(:replacement_consumable_two_2_adjustment).error?
    assert Adjustment.last.created?
  end
end
