require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "new user should be valid" do
    user = User.new(first_name: "Bob", last_name: "Duffy", email: "user@thalesgroup.com", profile: profiles(:technician), home_station: stations(:lhr), default_airline: airlines(:baw), phone_number: "123-456-7890",country_code: "United Stated  +1")
    assert user.valid?
  end

  test "password can be changed" do
    user = User.last
    user.password = "SomeNewValidPassword123*"
    assert user.valid?
  end

  test "invalid password" do
    user = User.last
    user.password = "not_good_enough"
    assert user.invalid?
  end

  test "secondary email" do
    assert_equal users(:albert).secondary_email, "therealalbert@thalesinflight.com"
  end

  test "secondary email falls back to email if not present" do
    assert_equal users(:user_with_no_secondary).secondary_email, "bernie.sanders@thalesinflight.com"
  end

  # test "new user should have expired password" do
  #   Current.user = users(:albert)
  #   User.create! first_name: "Chris", last_name: "Swann", email: "chris.swann1@thalesinflight.com", password: "Foobar123%", profile: profiles(:technician), home_station: stations(:lhr), default_airline: airlines(:baw), phone_number: "123-456-7890", country_code: "United Stated  +1"
  #   assert User.last.password_expired?
  # end

  test "new user setup can be bypassed" do
    Current.user = users(:albert)
    User.create! requires_new_user_setup: false, first_name: "Chris", last_name: "Swann", email: "chris.swann2@thalesinflight.com", password: "Foobar123%", profile: profiles(:technician), home_station: stations(:lhr), default_airline: airlines(:baw), phone_number: "123-456-7890", country_code: "United Stated  +1"
    assert_not User.last.password_expired?
  end

  test "user cannot change own profile" do
    user = users(:chris)
    Current.user = user
    assert user.admin?

    user.update(profile: profiles(:thales_engineering))
    assert user.invalid?
    refute_empty user.errors[:profile]
  end

end
