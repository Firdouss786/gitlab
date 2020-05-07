require 'test_helper'

class Users::QualificationsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:chris)
    @src = 'ABC12345'
    sign_in_as @user
  end

  test "should get index" do
    get user_qualifications_path(@user)
    assert_response :success
  end

  test "should update users qualification" do
    assert_nil @user.user_src_number

    patch user_qualifications_path(@user), params: { user: { user_src_number: @src } }
    follow_redirect!

    assert_select '#user_user_src_number[value=?]', @src
    assert_equal @user.reload.user_src_number, @src
  end

end
