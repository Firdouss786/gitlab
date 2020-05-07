require 'test_helper'

class LevelRecommendationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @level_recommendation = level_recommendations(:dual_usb_level)
    sign_in_as users(:chris)
  end

  test "should get index" do
    get level_recommendations_url
    assert_response :success
  end

  test "should get new" do
    get new_level_recommendation_url
    assert_response :success
  end

  test "should create level_recommendation" do
    assert_difference('LevelRecommendation.count') do
      post level_recommendations_url, params: { level_recommendation: { product_id: @level_recommendation.product_id, recommended_quantity: @level_recommendation.recommended_quantity, stock_location_id: @level_recommendation.stock_location_id } }
    end

    assert_redirected_to level_recommendation_url(LevelRecommendation.last)
  end

  test "should show level_recommendation" do
    get level_recommendation_url(@level_recommendation)
    assert_response :success
  end

  test "should get edit" do
    get edit_level_recommendation_url(@level_recommendation)
    assert_response :success
  end

  test "should update level_recommendation" do
    patch level_recommendation_url(@level_recommendation), params: { level_recommendation: { product_id: @level_recommendation.product_id, recommended_quantity: @level_recommendation.recommended_quantity, stock_location_id: @level_recommendation.stock_location_id } }
    assert_redirected_to level_recommendation_url(@level_recommendation)
  end

  test "should destroy level_recommendation" do
    assert_difference('LevelRecommendation.count', -1) do
      delete level_recommendation_url(@level_recommendation)
    end

    assert_redirected_to level_recommendations_url
  end
end
