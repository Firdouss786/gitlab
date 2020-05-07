require 'test_helper'

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  include ActionMailer::TestHelper

  test "should get password reset path" do
    get new_password_reset_url
    assert_response :success
    assert_select 'h1', "Password Reset"
  end

  test "should send password reset email when user submits email address" do
    assert_enqueued_emails 1 do
      post password_resets_url, params: { password_reset: { email: users(:chris).email } }
    end

    follow_redirect!

    assert_equal "Your reset token has been emailed to you", flash[:notice]
  end

  test "should fail if user is not found" do
    assert_enqueued_emails 0 do
      post password_resets_url, params: { password_reset: { email: "unknown@email.com" } }
    end

    follow_redirect!

    assert_equal "Unable to find email address", flash[:alert]
  end

  test "should render password reset edit path with GID" do
    reset_token = users(:chris).to_sgid(expires_in: 10.minutes, for: 'password_reset').to_s
    get edit_password_reset_url(reset_token)
    assert_response :success
    assert_select 'h1', "Change your password"
  end

  test "should redirect to login if reset token is expired" do
    reset_token = users(:chris).to_sgid(expires_in: 0.seconds, for: 'password_reset').to_s
    get edit_password_reset_url(reset_token)

    follow_redirect!
    assert_equal "Reset Token Expired", flash[:alert]
  end

  test "should redirect to login if reset token has been tampered with" do
    reset_token = users(:chris).to_sgid(expires_in: 10.minutes, for: 'password_reset').to_s + "-tampered"
    get edit_password_reset_url(reset_token)

    follow_redirect!
    assert_select 'h1', "Servo"
  end

  test "should redirect to login if token is not a password reset token" do
    reset_token = users(:chris).to_sgid(expires_in: 10.minutes, for: 'some_other_token').to_s
    get edit_password_reset_url(reset_token)

    follow_redirect!
    assert_select 'h1', "Servo"
  end

  test "should allow password to be changed" do
    reset_token = users(:chris).to_sgid(expires_in: 10.minutes, for: 'password_reset').to_s
    get edit_password_reset_url(reset_token)

    put password_reset_url(users(:chris)), params: { user: { password: "password123A*" } }

    follow_redirect!
    assert_equal "Your password has been reset", flash[:notice]
  end

  test "should reject invalid password" do
    reset_token = users(:chris).to_sgid(expires_in: 10.minutes, for: 'password_reset').to_s
    get edit_password_reset_url(reset_token)

    put password_reset_url(users(:chris)), params: { user: { password: "password" } }

    assert_select "[data-test-id='error_explanation']", "Password must contain at least 1 special character"
  end

  test "password expiry date should be in the future once reset is complete" do
    user = users(:expired_password_user)
    assert user.password_expired?
    assert_equal user.password_expires_at.end_of_day, (Time.current - 2.days).end_of_day

    reset_token = user.to_sgid(expires_in: 10.minutes, for: 'password_reset').to_s
    get edit_password_reset_url(reset_token)
    put password_reset_url(user), params: { user: { password: "password123A*" } }

    assert_equal user.reload.password_expires_at.end_of_day, (Time.current + 1.year).end_of_day
  end

end
