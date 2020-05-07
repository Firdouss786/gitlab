require 'test_helper'

class IssuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @airline = airlines(:baw)
    @fault = faults(:tsr)
    sign_in_as users(:chris)
  end

  # test "should get airline issues index" do
  #   get airline_issues_url(@airline)
  #   assert_response :success
  #   assert_select '.header__name', "Troubleshooting Requests"
  # end
  #
  # test "should get new" do
  #   get new_airline_issue_url(@airline, @fault)
  #   assert_response :success
  # end
  #
  # test "should create issue" do
  #   assert_difference('@airline.faults.count') do
  #     post airline_issues_url(@airline), params: { fault_issue: { aircraft_id: @fault.aircraft_id, mcc_description: "This is a new description", seats_impacted: "21A" } }
  #   end
  #
  #   assert_redirected_to airline_issues_url(@airline)
  # end
  #
  # test "creating an issue with a missing mcc_description should fail" do
  #   assert_no_difference('@airline.faults.count') do
  #     post airline_issues_url(@airline), params: { fault_issue: { aircraft_id: @fault.aircraft_id, mcc_description: nil, seats_impacted: "21A" } }
  #   end
  #
  #   assert_select "#error_explanation li", text: "Mcc description can't be blank"
  # end
  #
  # test "should show airline issue" do
  #   get airline_issues_url(@airline, @fault)
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get edit_issue_url(@fault)
  #   assert_response :success
  # end
  #
  # test "should update airline issue" do
  #   patch issue_url(@fault), params: { fault_issue: { aircraft_id: @fault.aircraft_id, mcc_description: "This is a new description", seats_impacted: "21A" }, redirect_to: airline_issues_path(@airline) }
  #
  #   assert_redirected_to airline_issues_url(@airline)
  # end
#
#   test "should destroy issue" do
#     assert_difference('Issue.count', -1) do
#       delete issue_url(@issue)
#     end
#
#     assert_redirected_to issues_url
#   end
end
