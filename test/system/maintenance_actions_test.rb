# require "application_system_test_case"
#
# class MaintenanceActionsTest < ApplicationSystemTestCase
#   setup do
#     @maintenance_action = maintenance_actions(:one)
#   end
#
#   test "visiting the index" do
#     visit maintenance_actions_url
#     assert_selector "h1", text: "Maintenance Actions"
#   end
#
#   test "creating a Maintenance action" do
#     visit maintenance_actions_url
#     click_on "New Maintenance Action"
#
#     fill_in "Description", with: @maintenance_action.description
#     fill_in "Name", with: @maintenance_action.name
#     click_on "Create Maintenance action"
#
#     assert_text "Maintenance action was successfully created"
#     click_on "Back"
#   end
#
#   test "updating a Maintenance action" do
#     visit maintenance_actions_url
#     click_on "Edit", match: :first
#
#     fill_in "Description", with: @maintenance_action.description
#     fill_in "Name", with: @maintenance_action.name
#     click_on "Update Maintenance action"
#
#     assert_text "Maintenance action was successfully updated"
#     click_on "Back"
#   end
#
#   test "destroying a Maintenance action" do
#     visit maintenance_actions_url
#     page.accept_confirm do
#       click_on "Destroy", match: :first
#     end
#
#     assert_text "Maintenance action was successfully destroyed"
#   end
# end
