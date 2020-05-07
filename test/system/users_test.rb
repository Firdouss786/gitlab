require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    browser_sign_in_as users(:chris)
  end

  test "unfurling the avatar on a navbar" do
    schedule_container_selector = "div#title__heading"

    first('#option-bar__user-button').click
    assert_selector(schedule_container_selector, visible: :visible)
  end

end
