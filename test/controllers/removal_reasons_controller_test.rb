require 'test_helper'

class RemovalReasonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @removal_reason = removal_reasons(:one)
    sign_in_as users(:chris)
  end

  test "should get index" do
    get removal_reasons_url
    assert_response :success
  end

  test "should get new" do
    get new_removal_reason_url
    assert_response :success
  end

  test "should create removal_reason" do
    assert_difference('RemovalReason.count') do
      post removal_reasons_url, params: { removal_reason: { description: @removal_reason.description, name: @removal_reason.name, product_category_id: @removal_reason.product_category_id } }
    end

    assert_redirected_to removal_reason_url(RemovalReason.last)
  end

  test "should show removal_reason" do
    get removal_reason_url(@removal_reason)
    assert_response :success
  end

  test "should get edit" do
    get edit_removal_reason_url(@removal_reason)
    assert_response :success
  end

  test "should update removal_reason" do
    patch removal_reason_url(@removal_reason), params: { removal_reason: { description: @removal_reason.description, name: @removal_reason.name, product_category_id: @removal_reason.product_category_id } }
    assert_redirected_to removal_reason_url(@removal_reason)
  end

  # test "should destroy removal_reason" do
  #   assert_difference('RemovalReason.count', -1) do
  #     delete removal_reason_url(@removal_reason)
  #   end
  #
  #   assert_redirected_to removal_reasons_url
  # end
end
