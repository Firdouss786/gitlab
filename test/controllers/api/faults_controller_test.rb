require 'test_helper'

class FaultsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in_as users(:chris)
    @activity = activities(:open_wp)
    @airline = airlines(:baw)
    @fault = faults(:fault_opened_in_wp)
  end

  # ==========
  # API TESTS
  # ==========

  # Update API tests after asking Chris if we will need them outside activity or inside activity

  # test "API should get all faults" do
  #   get airline_faults_url @airline, format: :json
  #   assert_response :success
  #   assert_equal JSON.parse(response.body).count, 3
  # end
  #
  # test "API should get a fault" do
  #   get fault_url @fault, format: :json
  #   assert_response :success
  #   assert_equal Fault.find_by_id(JSON.parse(response.body)["id"]), @fault
  # end
  #
  # test "API should create new fault" do
  #   assert_difference '@airline.faults.count' do
  #     post airline_faults_path @airline, params: { fault: { logbook_reference: "E123623/1", discovered: "ON GROUND", discrepancy_id: discrepancies(:no_avod_at_seat), recorded_by_id: users(:chris), logbook_text: "Fault created via API", aircraft_id: aircrafts(:gstba), cid: true } }, format: :json
  #     assert_response 201, :created
  #   end
  # end
  #
  # test "API should not create fault if discovered is misssing" do
  #   assert_no_difference '@airline.faults.count' do
  #     post airline_faults_path @airline, params: { fault: { logbook_reference: "E123623/1", discrepancy_id: discrepancies(:no_avod_at_seat), recorded_by_id: users(:chris), logbook_text: "Fault created via API", aircraft_id: aircrafts(:gstba), cid: true, inbound_deferred: false, raised_on_flight: 132, action_carried: "SEATRESET" } }, format: :json
  #     assert_response 422, :unprocessable_entity
  #   end
  # end
  #
  # test "API should not create fault if discovered-in-flight and raised-on-flight is misssing" do
  #   assert_no_difference '@airline.faults.count' do
  #     post airline_faults_path @airline, params: { fault: { logbook_reference: "E123623/1", discovered: "IN FLIGHT", discrepancy_id: discrepancies(:no_avod_at_seat), recorded_by_id: users(:chris), logbook_text: "Fault created via API", aircraft_id: aircrafts(:gstba), confirmed: true, cid: true, inbound_deferred: false, action_carried: "SEATRESET" } }, format: :json
  #     assert_response 422, :unprocessable_entity
  #   end
  # end
  #
  # test "API should not create fault if discovered-in-flight plus failure-confirmed-no and action-carried is misssing" do
  #   assert_no_difference '@airline.faults.count' do
  #     post airline_faults_path @airline, params: { fault: { logbook_reference: "E123623/1", discovered: "IN FLIGHT", discrepancy_id: discrepancies(:no_avod_at_seat), recorded_by_id: users(:chris), logbook_text: "Fault created via API", aircraft_id: aircrafts(:gstba), confirmed: false, inbound_deferred: false, raised_on_flight: 132 } }, format: :json
  #     assert_response 422, :unprocessable_entity
  #   end
  # end
  #
  # test "API should not create fault if discovered-in-flight plus inbound-deferred-yes and deferral-reference is misssing" do
  #   assert_no_difference '@airline.faults.count' do
  #     post airline_faults_path @airline, params: { fault: { logbook_reference: "E123623/1", discovered: "IN FLIGHT", discrepancy_id: discrepancies(:no_avod_at_seat), recorded_by_id: users(:chris), logbook_text: "Fault created via API", aircraft_id: aircrafts(:gstba), confirmed: false, inbound_deferred: true, raised_on_flight: 132, action_carried: "SEATRESET" } }, format: :json
  #     assert_response 422, :unprocessable_entity
  #   end
  # end
  #
  # test "API should update a fault" do
  #   text = "Fault updated via API"
  #   assert_no_difference '@airline.faults.count' do
  #     patch fault_path @fault, params: { fault: { logbook_text: text } }, format: :json
  #     assert_response :success
  #     assert_equal Fault.find_by_id(JSON.parse(response.body)["id"]).logbook_text, text
  #   end
  # end
  #
  # test "API should delete a fault" do
  #   assert_no_difference '@airline.faults.count' do
  #     assert @fault.active?
  #     delete fault_path @fault, format: :json
  #
  #     assert @fault.reload.error?
  #     assert_response 204, :no_content
  #   end
  # end

end
