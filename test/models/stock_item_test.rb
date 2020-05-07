# require 'test_helper'
#
# class StockItemTest < ActiveSupport::TestCase
#
#   # -------------------
#   # Class Tests
#   # -------------------
#
#
#   # -------------------
#   # Receive Event
#   # -------------------
#   test "StockItem can be recieved from transiting" do
#     assert_event_allowed stock_items(:transiting), :receive
#   end
#
#   test "StockItem can be recieved from transiting and has an associated transfer by the correct user" do
#     stock_items(:transiting).receive users(:two)
#     assert_equal users(:two), stock_items(:transiting).transfers.first.created_by
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem can only be received at a station the user has access to" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "Receiving a StockItem will invalidate the shipment paperwork" do
#     assert true
#   end
#
#
#   # -------------------
#   # Make Serviceable Event
#   # -------------------
#   test "StockItem can be made serviceable from inspecting" do
#     assert_event_allowed stock_items(:inspecting), :make_serviceable
#   end
#
#   test "StockItem cannot be made serviceable with an invalid cert" do
#     refute_event_allowed stock_items(:inspecting_without_cert), :make_serviceable!
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem can be made serviceable with valid cert" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem can only be made serviceable at a station the user has access to" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem can be made serviceable and has an associated transfer" do
#     assert true
#   end
#
#
#   # -------------------
#   # Install Event
#   # -------------------
#
#   # TODO: Stubbed Test
#   test "StockItem can be installed from serviceable" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem can only be installed at a station the user has access to" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem cannot be installed with an invalid cert" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem can be installed with valid cert" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem can only be installed to an aircraft that is at a station the user has access to" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem can be installed and has an associated transfer" do
#     assert true
#   end
#
#
#   # -------------------
#   # Remove Event
#   # -------------------
#
#   # TODO: Stubbed Test
#   test "StockItem can be removed from installed" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem can only be removed from an aircraft that is at a station the user has access to" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem can be removed and has an associated transfer" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem can be removed and still has a valid cert" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "A removed StockItem can installed on a new aircraft" do
#     assert true
#   end
#
#
#   # -------------------
#   # Make Unserviecable Event
#   # -------------------
#   test "StockItem can be made unserviceable from removed" do
#     stock_items(:serviceable).make_unserviceable users(:two)
#     assert_equal "unserviceable", stock_items(:serviceable).state
#   end
#
#   test "StockItem certificates are invalidated when it is made unserviceable" do
#     stock_items(:serviceable).make_unserviceable users(:albert)
#     assert_equal 0, stock_items(:serviceable).certificates.valid.count
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem can be made unserviceable and has an associated transfer" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem can only be made unserviceable at a station the user has access to" do
#     assert true
#   end
#
#
#   # -------------------
#   # Ship Event
#   # -------------------
#
#   # TODO: Stubbed Test
#   test "StockItem can be shipped from from unserviceable" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem can be shipped with valid shipment paperwork" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem cannot be shipped with invalid or missing shipment paperwork" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem transfer is created when StockItem is shipped" do
#     assert true
#   end
#
#
#   # -------------------
#   # Redirect Shipment Event
#   # -------------------
#   test "StockItem will have a new destination if it is recirected while transiting" do
#     stock_items(:transiting).redirect_shipment! users(:albert), stock_locations(:three)
#     assert_equal stock_locations(:three), stock_items(:transiting).lastest_transfer.destination_stock_location
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem can be redirected with valid shipment paperwork" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem cannot be redirected with invalid or missing shipment paperwork" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem transfer is created when StockItem is redirected" do
#     assert true
#   end
#
#
#   # -------------------
#   # Repair Event
#   # -------------------
#
#   # This is a custom method on the StockItem class which invokes several events in the StockItem state machine
#   test "StockItem can be cycled through repair from a station (ship, receive, repair, ship)" do
#     stock_items(:unserviceable).cycle_through_repair by_user: users(:albert), through: stock_locations(:one)
#     assert_equal stock_locations(:two), stock_items(:unserviceable).stock_location
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem can be repaired from inspecting" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "The StockItem's certificates are invalidated on repair" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem can be repaired with a valid repair order" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem cannot be repaired with an invalid repair order" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem has a factory reset task applied to remove content and software" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem transfer is created when StockItem is repaired" do
#     assert true
#   end
#
#
#   # -------------------
#   # Quarantine Event
#   # -------------------
#
#   # TODO: Stubbed Test
#   test "StockItem can only be quarantined at a station the user has access to" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem lock is applied when the part is quarantined" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem can be transfered from quarantined to inspect" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem transfer is created when StockItem is quarantined" do
#     assert true
#   end
#
#   # -------------------
#   # Scrap Event
#   # -------------------
#
#   # TODO: Stubbed Test
#   test "StockItem can only be scrapped at a station the user has access to" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem lock is applied when the part is scrapped" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem can be scrapped with a valid scrap certificate" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem cannot be scrapped without a valid scrap certificate" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "The scrap certificate is transmited afer the StockItem is scrapped" do
#     assert true
#   end
#
#   # TODO: Stubbed Test
#   test "StockItem transfer is created when StockItem is scrapped" do
#     assert true
#   end
#
# end
