require 'test_helper'

class Users::TokensControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:albert)
    @activated_user = users(:albert)
    @unactivated_user   = users(:george)
  end

  test "should get new" do
    sign_in_as users(:albert)

    get new_user_token_path(@user)
    assert_response :success
    assert_select '.nav__leaf--active', "Developer Settings"
  end

  test "should create user_token" do
    sign_in_as users(:albert)

    assert_nil @user.token

    post user_tokens_url(@user), params: { reason_for_token: "reason for access", user_id: @user.id }

    assert @user.reload.token
  end

  test "should not create a token if the user is not me" do
    sign_in_as users(:chris)

    post user_tokens_url(@user), params: { reason_for_token: "reason for access", user_id: @user.id }

    assert_nil @user.token
    assert_equal flash[:notice], 'You can only generate an API token for your own user'
  end

  test "Allow authorized API user" do
    get '/airlines.json', headers: {"Authorization": "Bearer token=#{users(:john).token}", "Accept": "application/json"}

    assert_equal 200, status
  end

  test "Disallow unauthorized API user" do
    get '/airlines.json', headers: {"Authorization": "Bearer token=#{users(:chris).token}", "Accept": "application/json"}

    assert_equal 401, status
  end

  test "Allow authorized API user with unlocked account" do
    sign_in_as users(:albert)
    get '/airlines.json', headers: {"Authorization": "Bearer token=#{@activated_user.token}", "Accept": "application/json"}

    assert_equal 200, status
   end

  test "Disallow authorized API with locked account" do
    sign_in_as users(:george)
    get '/airlines.json', headers: {"Authorization": "Bearer token=#{@unactivated_user.token}", "Accept": "application/json"}
    assert_equal 401, status
  end

end
