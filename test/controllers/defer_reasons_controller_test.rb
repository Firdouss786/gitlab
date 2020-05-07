require 'test_helper'

class DeferReasonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @defer_reason = defer_reasons(:no_access)
    @duplicate_defer_reason = defer_reasons(:no_parts)
    sign_in_as users(:chris)
  end

  test "should get index" do
    get defer_reasons_url
    assert_response :success
  end

  test "should get new" do
    get new_defer_reason_url
    assert_response :success
  end

  test "should create defer_reason" do
    assert_difference('DeferReason.count') do
      post defer_reasons_url, params: { defer_reason: { description: 'SIA Specific: Verified content problem', name: 'CONTENT ISSUE' } }
    end

    assert_redirected_to defer_reasons_url
    follow_redirect!
    assert_select '[data-test-id="error_explanation"]', "Defer reason was successfully created."
  end

  test "should show defer_reason" do
    get defer_reason_url(@defer_reason)
    assert_response :success
  end

  test "should get edit" do
    get edit_defer_reason_url(@defer_reason)
    assert_response :success
  end

  test "should update defer_reason" do
    patch defer_reason_url(@defer_reason), params: { defer_reason: { description: @defer_reason.description, name: @defer_reason.name } }
    assert_redirected_to defer_reasons_url
    follow_redirect!
    assert_select '[data-test-id="error_explanation"]', "Defer reason was successfully updated."
  end

  test "should destroy defer_reason" do
    @defer_reason = defer_reasons(:defer_reason_delete)
    assert_difference('DeferReason.count', -1) do
      delete defer_reason_url(@defer_reason)
    end

    assert_redirected_to defer_reasons_url
    follow_redirect!
    assert_select '[data-test-id="error_explanation"]', "Defer reason was successfully destroyed."
  end
end
