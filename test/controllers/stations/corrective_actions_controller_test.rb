require 'test_helper'

class Stations::CorrectiveActionsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in_as users(:chris)
    @station = stations(:lhr)
    @ca = corrective_actions(:system_reset)
    @ca_consumable = corrective_actions(:consumable_replacement)
    @ca_rotable = corrective_actions(:rotable_replacement)
    @ca_deferral = corrective_actions(:ca_deferral_three)
  end

  test "show" do
    get station_corrective_action_path(@station, @ca)
    assert_response :success

    assert_select 'span', text: @ca.logbook_text
  end

  test "show consumable" do
    get station_corrective_action_path(@station, @ca_consumable)
    assert_response :success

    assert_select 'span', text: @ca_consumable.logbook_text
  end

  test "show rotable" do
    get station_corrective_action_path(@station, @ca_rotable)
    assert_response :success

    assert_select 'span', text: @ca_rotable.logbook_text
  end

  test "show deferral" do
    get station_corrective_action_path(@station, @ca_deferral)
    assert_response :success

    assert_select 'span', text: @ca_deferral.logbook_text
  end

end
