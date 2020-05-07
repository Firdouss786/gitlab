require 'test_helper'

class JumpMenuTest < ActionDispatch::IntegrationTest

  test 'chris should see the correct number of stations' do
    sign_in_as users(:chris)

    get station_activities_path stations(:lhr)
    assert_response :success

    assert_select '[data-test-id="user-stations"]', count: 1
  end

  test 'albert should see the correct number of stations' do
    sign_in_as users(:albert)

    get station_activities_path stations(:lhr)
    assert_response :success

    assert_select '[data-test-id="user-stations"]', count: 1
  end
end
