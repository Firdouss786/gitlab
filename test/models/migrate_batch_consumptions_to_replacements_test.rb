require 'test_helper'

class MigrateBatchConsumptionsToReplacementsTest < ActiveSupport::TestCase

  test "Should create stock item and transfer if the batch is orphaned" do
    assert_difference("Transfer.count", +1) do
      assert_difference("StockItem.count", +1) do
        assert_difference("Replacement.count", +2) do
          MigrateBatchConsumptionsToReplacements.perform(
            days_ago: 10,
            dest_stock_location_id: stock_locations(:cdg).id,
            user_id: users(:chris).id
          )
        end
      end
    end
  end

  test "Should create only a replacement if the batch is orphaned" do
    assert_difference("Replacement.count", +2) do
      MigrateBatchConsumptionsToReplacements.perform(
        days_ago: 10,
        dest_stock_location_id: stock_locations(:cdg).id,
        user_id: users(:chris).id
      )
    end

    assert_equal "FAKEBATCHNUM", StockItem.last.batch_number
    assert_equal products(:dual_usb), StockItem.last.product
    assert_equal 0, StockItem.last.quantity
    assert_equal "quarantined", StockItem.last.state

    assert_equal StockItem.last, Transfer.last.stock_item
  end
end
