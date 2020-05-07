require 'test_helper'

class Users::SecuritiesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:chris)
    sign_in_as @user
  end

  test "should get index" do
    get user_security_path(@user)
    assert_response :success
  end

  test "should update user security" do
    assert_equal @user.requires_verification, false
    assert_equal @user.locked, false

    patch user_security_path(@user), params: { user: { requires_verification: true, locked: true } }

    @user.reload
    assert_equal @user.requires_verification, true
    assert_equal @user.locked, true
  end

end
