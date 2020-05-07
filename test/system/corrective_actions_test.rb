require "application_system_test_case"

class CorrectiveActionsTest < ApplicationSystemTestCase

  setup do
    browser_sign_in_as users(:chris)
    @activity = activities(:open_wp)
    @fault = faults(:fault_opened_in_wp)
    @ca = corrective_actions(:system_reset)
    @job_started_selector = '#corrective_action_job_started_at'
  end

  test "creating a corrective action" do
    visit activity_fault_path(@activity, @fault)
    click_on "Add Action"

    find(@job_started_selector).click
    find('.bootstrap-datetimepicker-widget').click

    fill_in "Logbook reference", with: @ca.logbook_reference
    select("PARTIAL SYSTEM RESET", from: "corrective_action[maintenance_action_id]").select_option
    fill_in "Logbook text", with: @ca.logbook_text
    fill_in "Document reference", with: @ca.document_reference

    click_on "Create Corrective action"
    click_button #fault_resolution_state_false
    click_on "Save Fault resolution"

    assert_text "Defer"
  end

  test "creating a corrective action with replaced consumable" do
    @ca = corrective_actions(:consumable_replacement)
    visit activity_fault_path(@activity, @fault)
    click_on "Add Action"

    find(@job_started_selector).click
    fill_in "Logbook reference", with: @ca.logbook_reference
    select("REPLACED CONSUMABLE", from: "corrective_action[maintenance_action_id]").select_option
    select(@ca.replacement.installed_product.part_number, from: "corrective_action[replacement_attributes][installed_product_id]").select_option
    select(@ca.replacement.installed_stock_item.batch_number, from: "corrective_action[replacement_attributes][installed_stock_item_id]").select_option
    fill_in "corrective_action[replacement_attributes][install_quantity]", with: @ca.replacement.installed_stock_item.quantity
    fill_in "Logbook text", with: @ca.logbook_text
    fill_in "Document reference", with: @ca.document_reference

    click_on "Create Corrective action"
    click_button #fault_resolution_state_false
    click_on "Save Fault resolution"

    assert_text "Defer"
  end

  test "creating a corrective action with replaced rotable" do
    @ca = corrective_actions(:rotable_replacement)
    visit activity_fault_path(@activity, @fault)
    click_on "Add Action"

    find(@job_started_selector).click
    fill_in "Logbook reference", with: @ca.logbook_reference
    select("REPLACED LRU", from: "corrective_action[maintenance_action_id]").select_option
    fill_in "corrective_action[replacement_attributes][on_wing_position]", with: @ca.replacement.on_wing_position
    select(@ca.replacement.removed_product.part_number, from: "corrective_action[replacement_attributes][removed_product_id]").select_option
    fill_in "corrective_action[replacement_attributes][removed_stock_item_id]", with: @ca.replacement.removed_stock_item.serial_number
    select(@ca.replacement.installed_product.part_number, from: "corrective_action[replacement_attributes][installed_product_id]").select_option
    select(@ca.replacement.installed_stock_item.serial_number, from: "corrective_action[replacement_attributes][installed_stock_item_id]").select_option
    fill_in "Logbook text", with: @ca.logbook_text
    fill_in "Document reference", with: @ca.document_reference

    click_on "Create Corrective action"
    click_button #fault_resolution_state_false
    click_on "Save Fault resolution"

    assert_text "Defer"
  end

  test "updating a corrective action" do
    @ca = corrective_actions(:consumable_replacement_two)
    visit activity_fault_corrective_action_path(@activity, @fault, @ca)
    click_on "Edit"

    select("REPLACED CONSUMABLE", from: "corrective_action[maintenance_action_id]").select_option
    select(@ca.replacement.installed_product.part_number, from: "corrective_action[replacement_attributes][installed_product_id]").select_option
    select(@ca.replacement.installed_stock_item.batch_number, from: "corrective_action[replacement_attributes][installed_stock_item_id]").select_option
    fill_in "corrective_action[replacement_attributes][install_quantity]", with: 1
    click_on "Update Corrective action"
    click_button #fault_resolution_state_false
    click_on "Save Fault resolution"

    assert_text "Defer"
  end

  test "destroying a corrective action" do
    @ca = corrective_actions(:ca_actioned_and_raised_in_wp)
    visit activity_fault_path(@activity, @ca.fault)
    assert_selector(:css, 'a[href="' + "#{activity_fault_corrective_action_path(@activity, @fault, @ca)}" + '"]', count: 1)
    visit activity_fault_corrective_action_path(@activity, @fault, @ca)

    page.accept_confirm do
      click_on "Delete", match: :first
    end
    assert_selector(:css, 'a[href="' + "#{activity_fault_corrective_action_path(@activity, @fault, @ca)}" + '"]', count: 0)
  end

  test "cannot destroy corrective action if originating activity is in complete or error state" do
    @closed_activity = activities(:closed_wp)
    @ca = corrective_actions(:ca_raised_in_activity)

    visit activity_fault_corrective_action_path(@closed_activity, @fault, @ca)
    page.accept_confirm do
      click_on "Delete", match: :first
    end

    assert_text "Corrective Action can only be destroyed within its originating activity and before workpack close."
  end


  # ============ DYNAMIC FORM TESTS ============

  test "new corrective action form should not show consumable and rotable fields" do
    visit activity_corrective_action_path(@activity, @ca)
    click_on "Edit"

    assert_selector "#cProduct", visible: :hidden
    assert_selector "#cBatchNumber", visible: :hidden
    assert_selector "#cInstallQuantity", visible: :hidden

    assert_selector "#rWingPosition", visible: :hidden
    assert_selector "#rRemovedProduct", visible: :hidden
    assert_selector "#rRemovedStockItem", visible: :hidden
    assert_selector "#rRemovedModel", visible: :hidden
    assert_selector "#rRemovedRevision", visible: :hidden
    assert_selector "#rInstalledProduct", visible: :hidden
    assert_selector "#rInstalledStockItem", visible: :hidden
  end

  test "new corrective action form should show consumable fields if consumable is selected" do
    @ca = corrective_actions(:consumable_replacement)
    visit activity_corrective_action_path(@activity, @ca)
    click_on "Edit"

    select("REPLACED CONSUMABLE", from: "corrective_action[maintenance_action_id]").select_option
    assert_selector "#cProduct", visible: :visible

    select(@ca.replacement.installed_product.part_number, from: "corrective_action[replacement_attributes][installed_product_id]").select_option
    assert_selector "#cBatchNumber", visible: :visible

    select(@ca.replacement.installed_stock_item.batch_number, from: "corrective_action[replacement_attributes][installed_stock_item_id]").select_option
    assert_selector "#cInstallQuantity", visible: :visible

    assert_selector "#rWingPosition", visible: :hidden
    assert_selector "#rRemovedProduct", visible: :hidden
    assert_selector "#rRemovedStockItem", visible: :hidden
    assert_selector "#rRemovedModel", visible: :hidden
    assert_selector "#rRemovedRevision", visible: :hidden
    assert_selector "#rInstalledProduct", visible: :hidden
    assert_selector "#rInstalledStockItem", visible: :hidden
  end

  test "new corrective action form should show rotable fields if rotable is selected" do
    @ca = corrective_actions(:rotable_replacement)
    visit activity_corrective_action_path(@activity, @ca)
    click_on "Edit"

    select("REPLACED LRU", from: "corrective_action[maintenance_action_id]").select_option
    assert_selector "#rWingPosition", visible: :visible
    assert_selector "#rRemovedProduct", visible: :visible
    assert_selector "#rRemovedStockItem", visible: :visible
    assert_selector "#rRemovedModel", visible: :visible
    assert_selector "#rRemovedRevision", visible: :visible

    select(@ca.replacement.removed_product.part_number, from: "corrective_action[replacement_attributes][removed_product_id]").select_option
    assert_selector "#rInstalledProduct", visible: :visible
    assert_selector "#rInstalledStockItem", visible: :visible

    assert_selector "#cProduct", visible: :hidden
    assert_selector "#cBatchNumber", visible: :hidden
    assert_selector "#cInstallQuantity", visible: :hidden
  end

end
