require 'test_helper'

class CorrectiveActionTest < ActiveSupport::TestCase

  setup do
    Current.user = users(:chris)
    @ca_consumable = corrective_actions(:consumable_replacement_two)
    @ca_rotable = corrective_actions(:rotable_replacement_two)
  end

  test "consumable part must be in selected_aircraft_bom_consumables" do
    assert @ca_consumable.valid?, 'not accepting valid BOM part'

    @ca_consumable.replacement.installed_product = products(:screen)
    assert_not @ca_consumable.valid?, 'accepting invalid BOM part'
  end

  test "consumable batch number must be under selected part, available in-stock and servicable" do
    assert @ca_consumable.valid?, 'not accepting valid batch number'

    @ca_consumable.replacement.installed_stock_item = stock_items(:installed_screen)
    assert_not @ca_consumable.valid?, 'accepting invalid batch number'
  end

  test "consumable batch quantity must be positive and lower than or equal to stock quantity" do
    assert @ca_consumable.valid?, 'not accepting valid batch quantity'

    quantity_available = @ca_consumable.replacement.installed_stock_item.quantity

    @ca_consumable.replacement.install_quantity = quantity_available
    assert @ca_consumable.valid?, 'not accepting valid batch quantity'

    @ca_consumable.replacement.install_quantity = quantity_available + 1
    assert_not @ca_consumable.valid?, 'accepting invalid batch quantity'

    @ca_consumable.replacement.install_quantity = 0
    assert_not @ca_consumable.valid?, 'accepting invalid batch quantity'
  end

  test "rotable part off must be in selected_aircraft_bom_rotables" do
    assert @ca_rotable.valid?, 'not accepting valid BOM part'

    @ca_rotable.replacement.removed_product = products(:dual_usb)
    assert_not @ca_rotable.valid?, 'accepting invalid BOM part'
  end

  test "rotable serial off must be under selected part off and previously installed" do
    assert @ca_rotable.valid?, 'not accepting valid serial off number'

    @ca_rotable.replacement.removed_stock_item = nil
    assert_not @ca_rotable.valid?, 'accepting nil removed_stock_item'

    @ca_rotable.replacement.removed_stock_item = stock_items(:serviceable_screen)
    assert_not @ca_rotable.valid?, 'accepting invalid removed_stock_item'
  end

  test "rotable model off must be within range" do
    assert @ca_rotable.valid?, 'not accepting valid model numbers'

    @ca_rotable.replacement.removed_model_numbers = nil
    assert @ca_rotable.valid?, 'not accepting valid model input'

    empty_string = ""
    @ca_rotable.replacement.removed_model_numbers = empty_string
    assert @ca_rotable.valid?, 'accepting blank model input'

    array_with_empty_string = [""]
    @ca_rotable.replacement.removed_model_numbers = array_with_empty_string
    assert @ca_rotable.valid?

    single_model = "1"
    @ca_rotable.replacement.removed_model_numbers = single_model
    assert @ca_rotable.valid?, 'not accepting valid model numbers'

    multiple_with_out_string = "1, 2, 3"
    @ca_rotable.replacement.removed_model_numbers = multiple_with_out_string
    assert @ca_rotable.valid?, 'not accepting valid model numbers'

    multiple_ints_in_string = "[1, 2, 3]"
    @ca_rotable.replacement.removed_model_numbers = multiple_ints_in_string
    assert @ca_rotable.valid?, 'not accepting valid model numbers'

    out_of_range = ["100", "2"]
    @ca_rotable.replacement.removed_model_numbers = out_of_range
    assert_not @ca_rotable.valid?, 'accepting out_of_range model numbers'

    bad_input = ["abc", "22"]
    @ca_rotable.replacement.removed_model_numbers = bad_input
    assert_not @ca_rotable.valid?, 'accepting invalid model numbers'
  end

  test "rotable revision off must be within range" do
    assert @ca_rotable.valid?, 'not accepting valid revision'

    @ca_rotable.replacement.removed_revision = nil
    assert @ca_rotable.valid?, 'not accepting nil revision'

    empty_string = ""
    @ca_rotable.replacement.removed_revision = empty_string
    assert @ca_rotable.valid?, 'not skipping invalid revision'

    bad_input = "A, F"
    @ca_rotable.replacement.removed_revision = bad_input
    assert_not @ca_rotable.valid?, 'accepting bad_input revision'

    small_letter = "a"
    @ca_rotable.replacement.removed_revision = small_letter
    assert_not @ca_rotable.valid?, 'accepting small_letter revision'

    invalid_input = "1"
    @ca_rotable.replacement.removed_revision = invalid_input
    assert_not @ca_rotable.valid?, 'accepting invalid input as revision'
  end

  test "rotable part must be in selected_aircraft_bom_rotables of similar category" do
    assert @ca_rotable.valid?, 'not accepting valid BOM part'

    @ca_rotable.replacement.installed_product = products(:single_usb)
    assert_not @ca_rotable.valid?, 'accepting invalid BOM part'
  end

  test "rotable serial number must be under selected part, available in-stock and servicable" do
    assert @ca_rotable.valid?, 'not accepting valid serial number'

    @ca_rotable.replacement.installed_stock_item = stock_items(:consumable_with_no_history)
    assert_not @ca_rotable.valid?, 'accepting invalid serial number'
  end

end
