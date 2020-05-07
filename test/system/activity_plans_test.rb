require 'application_system_test_case'

class ActivityPlansTest < ApplicationSystemTestCase

  setup do
    @user = users(:chris)
    @station = stations(:lhr)
    browser_sign_in_as @user
  end

  test 'toggle visibility of breadcrumb station list' do
    visit station_activity_plans_path(@station)

    first('#icon-cheveron-down').click
    assert_selector('[data-test-id="user-stations"]', visible: :visible)
  end

end
