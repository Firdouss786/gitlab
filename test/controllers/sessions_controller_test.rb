require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get login_url
    assert_select 'h1', "Servo"
  end

  test "users requiring verification should be verified" do
    post login_url, params: { session: { email: users(:user_requiring_verification).email, password: "foobar" } }
    assert_select 'h1', 'Enter Verification Code'
  end

  test "users requiring password reset should be redirected" do
    post login_url, params: { session: { email: users(:expired_password_user).email, password: "foobar" } }
    assert_redirected_to new_password_reset_path
  end

  test "users not requiring verification should be redirected" do
    post login_url, params: { session: { email: users(:chris).email, password: "foobar" } }
    assert_redirected_to root_url
  end

  test "login with invalid information should return error" do
    post login_url, params: { session: { email: users(:chris).email, password: "wrongpasswordmate" } }

    assert_select "[data-test-id='error_explanation']", 'Incorrect Password. Try the \'Reset your password\' link bellow.'
  end

  test "when user is not found, should be redirected to login" do
    post login_url, params: { session: { email: "invalid_user@example.com", password: "wrongpasswordmate" } }

    assert_select "[data-test-id='error_explanation']", 'User does not exist. Please email support@thalesinflight.com for account creation'
  end

  test "locked account should inform user" do
    post login_url, params: { session: { email: users(:locked).email, password: "foobar" } }
    follow_redirect!

    assert_select 'div', 'Your account has been locked. Please contact support@thalesinflight.com for help unlocking your account.'
  end

  test "redirected to login page if no session" do
    get airlines_path
    follow_redirect!

    assert_select 'h1', "Servo"
  end

  test "redirected to login page on logout" do
    sign_in_as users(:chris)
    delete logout_url
    follow_redirect!

    assert_select 'h1', "Servo"
  end

  test "should not allow invalid verification code" do
    sign_in_as users(:user_requiring_verification)
    user_gid = users(:user_requiring_verification).to_sgid(expires_in: 10.minutes, for: 'verification_code').to_s

    assert_select 'h1', 'Enter Verification Code'

    post verify_url, params: { session: { verification_code: "123", user_gid: user_gid } }
    assert_select 'div', 'Invalid verification code'
  end

  test "should not allow expired" do
    sign_in_as users(:user_requiring_verification)

    verification_code = ROTP::TOTP.new(Rails.application.credentials.ROTP_key_base, issuer: "Firefly").now
    user_gid = users(:user_requiring_verification).to_sgid(expires_in: 10.minutes, for: 'verification_code').to_s
    travel 5.minutes
    post verify_url, params: { session: { verification_code: verification_code, user_gid: user_gid } }

    assert_redirected_to root_url
  end

  test "login with valid otp" do
    sign_in_as users(:user_requiring_verification)

    verification_code = ROTP::TOTP.new(Rails.application.credentials.ROTP_key_base, issuer: "Firefly").now
    user_gid = users(:user_requiring_verification).to_sgid(expires_in: 10.minutes, for: 'verification_code').to_s
    post verify_url, params: { session: { verification_code: verification_code, user_gid: user_gid } }

    assert_redirected_to root_url
  end

  test "having email feature enabled only should do email verification" do
    post login_url, params: { session: { email: users(:user_requiring_verification).email, password: "foobar" } }
    assert_select 'h1', 'Enter Verification Code'
  end

  test "having email feature disabled should bypass email verification" do
    FeatureFlag.where(name: "email_two_step_verification").first.update(enabled: false)
    post login_url, params: { session: { email: users(:user_requiring_verification).email, password: "foobar" } }
    assert_redirected_to root_url
  end
end
