require 'test_helper'

class CampaignsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:chris)
    @airline = airlines(:baw)
    @task_template = task_templates(:campaign_with_one_config)
  end

  test "should show airline campaign" do
    get airline_campaign_url(@airline, @task_template.campaign)
    assert_response :success

    assert_select '#title h1', "April 18 Content Load"
  end
end
