# require 'test_helper'
#
# class TransferTest < ActiveSupport::TestCase
#   test "Adding a transfer updates the stock item location" do
#     stock_items(:transiting).transfers.create!(
#       state: "CLOSED",
#       category: "TRANSFER",
#       source_stock_location: stock_locations(:lhr),
#       destination_stock_location: stock_locations(:cdg),
#       created_by: users(:chris),
#       sent_by: users(:chris),
#       received_by: users(:chris),
#       sent_at: DateTime.now,
#       from_state: "TEST",
#       to_state: "TEST"
#     )
#     assert_equal stock_locations(:cdg), stock_items(:transiting).stock_location
#   end
# end
