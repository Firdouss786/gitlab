require 'test_helper'

class SoftwarePlatformsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @software_platform = software_platforms(:one)
    sign_in_as users(:chris)
  end

  test "should get index" do
    get software_platforms_url
    assert_response :success
  end

  test "should get new" do
    get new_software_platform_url
    assert_response :success
  end

  test "should create software_platform" do
    assert_difference('SoftwarePlatform.count') do
      post software_platforms_url, params: { software_platform: { description: @software_platform.description, name: @software_platform.name } }
    end

    assert_redirected_to software_platforms_url
  end

  test "should show software_platform" do
    get software_platform_url(@software_platform)
    assert_response :success
  end

  test "should get edit" do
    get edit_software_platform_url(@software_platform)
    assert_response :success
  end

  test "should update software_platform" do
    patch software_platform_url(@software_platform), params: { software_platform: { description: @software_platform.description, name: @software_platform.name } }
    assert_redirected_to software_platforms_url
  end

  # TODO: Stub Test
  # test "should destroy software_platform" do
  #   assert_difference('SoftwarePlatform.count', -1) do
  #     delete software_platform_url(@software_platform)
  #   end
  #
  #   assert_redirected_to software_platforms_url
  # end
end
