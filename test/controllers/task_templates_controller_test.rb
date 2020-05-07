require 'test_helper'

class TaskTemplatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @airline = airlines(:baw)
    sign_in_as users(:chris)
  end

  test "should get index" do
    get airline_task_templates_url(@airline)
    assert_response :success

    assert_select '.nav__leaf--active', "Tasks"
  end

  test "should get new" do
    get new_airline_task_template_url(@airline)
    assert_response :success

    assert_select '.nav__leaf--active', "Tasks"
  end

  test "should create recurring task_template" do
    @task_template = task_templates(:recurring_level_2)

    assert_difference('TaskTemplate.recurring.count') do
      post airline_task_templates_url(@airline), params: { task_template: { description: @task_template.description, mode: @task_template.mode, name: @task_template.name, repeat_interval: @task_template.repeat_interval } }
    end

    assert_equal 10, TaskTemplate.last.repeat_interval

    assert TaskTemplate.last.recurring?

    assert_redirected_to airline_task_templates_url(TaskTemplate.last.airline)
  end

  test "should create campaign task_template" do
    @campaign = task_templates(:content_load)

    assert_difference('TaskTemplate.campaign.count') do
      post airline_task_templates_url(@airline), params:
        { task_template:
          { description: @campaign.description, mode: @campaign.mode, name: @campaign.name,
            campaign_attributes: { scheduled_end: "2018-04-30" },
            config_applicabilities_attributes: { "0": { "fleet_id": fleets(:B777).id, "selected": "1", "applicable_content": "1.2", "applicable_software": "3.4" } }
          }
        }
    end

    assert_equal 1, TaskTemplate.last.fleets.count

    assert TaskTemplate.last.campaign?

    assert_redirected_to airline_task_templates_url(TaskTemplate.last.airline)
  end

  test "should show task_template" do
    @task_template = task_templates(:recurring_level_2)

    get airline_task_template_url(@airline, @task_template)
    assert_response :success

    assert_select '#title h1', "Level 2"
  end

  test "should show task_template campaign" do
    @task_template = task_templates(:campaign_with_one_config)

    get airline_task_template_url(@airline, @task_template)
    assert_response :success

    assert_select '#title h1', "April 18 Content Load"
  end
end
