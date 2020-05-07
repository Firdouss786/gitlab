require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:chris)
  end

  # test "user should be redirected if their password has expired" do
  #   sign_in_as users(:expired_password_user)
  #
  #   assert_redirected_to new_password_reset_path
  # end

  test 'user should be redirected to login if not logged in' do
    assert get root_url
    assert_response :redirect
    assert_redirected_to login_url
  end

  test 'user should be redirected to root after logging in' do
    assert get login_url
    assert post login_url, params: { session: { email: @user.email, password: "foobar" } }
    assert_response :redirect
    assert_redirected_to root_url
  end

  test 'user should follow requested link if provided after login' do
    assert get stations_url
    assert_response :redirect
    assert_redirected_to login_url
    assert post login_url, params: { session: { email: @user.email, password: "foobar" } }
    assert_response :redirect
    assert_redirected_to stations_url
  end

  test 'user should be redirected to root if logging back in after logout' do
    sign_in_as @user
    assert_response :redirect
    assert_redirected_to root_url

    assert delete logout_url
    assert_response :redirect
    assert_redirected_to login_url

    assert post login_url, params: { session: { email: @user.email, password: "foobar" } }
    assert_response :redirect
    assert_redirected_to root_url
  end

end
