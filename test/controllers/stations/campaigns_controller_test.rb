require 'test_helper'

class Stations::CampaignsControllerTest < ActionDispatch::IntegrationTest

	setup do
		sign_in_as users(:chris)
		@station = stations(:lhr)
		@campaign = campaigns(:content_load)
	end

  test "index" do
    get station_campaigns_path(@station)
    assert_response :success

    assert_select '.table .table-head', count: 1
    assert_select '.table a.table-body', count: 2
  end

  test "show" do
    get station_campaign_path(@station, @campaign)
    assert_response :success

    assert_select 'div span', text: @campaign.task_template.name
		assert_select '.table .table-body', count: 1
  end
end
