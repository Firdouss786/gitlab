require 'test_helper'

class ProgramsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @program = programs(:british_airways)
    sign_in_as users(:chris)
  end

  # No Routing
  # test "should get index" do
  #   get programs_url
  #   assert_response :success
  # end

  # No Routing
  # test "should get new" do
  #   get new_program_url
  #   assert_response :success
  # end

  # No Routing
  # test "should create program" do
  #   assert_difference('Program.count') do
  #     post programs_url, params: { program: { airline_id: @program.airline_id, airport_id: @program.airport_id, mailing_group_1: @program.mailing_group_1, mailing_group_2: @program.mailing_group_2, mailing_group_3: @program.mailing_group_3, mcc_email: @program.mcc_email, repair_order_note: @program.repair_order_note } }
  #   end
  #
  #   assert_redirected_to program_url(Program.last)
  # end

  # No Routing
  # test "should show program" do
  #   get program_url(@program)
  #   assert_response :success
  # end

  test "should get edit" do
    get edit_program_url(@program)
    assert_response :success
  end

  test "should update program" do
    patch program_url(@program), params: { program: { airline_id: @program.airline_id, airport_id: @program.airport_id, mailing_group_1: @program.mailing_group_1, mailing_group_2: @program.mailing_group_2, mailing_group_3: @program.mailing_group_3, mcc_email: @program.mcc_email, repair_order_note: @program.repair_order_note } }
    assert_redirected_to airlines_url
  end

  # No Routing
  # test "should destroy program" do
  #   assert_difference('Program.count', -1) do
  #     delete program_url(@program)
  #   end
  #
  #   assert_redirected_to programs_url
  # end
end
