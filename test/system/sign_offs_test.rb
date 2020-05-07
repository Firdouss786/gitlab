require "application_system_test_case"

class SignOffsTest < ApplicationSystemTestCase

  setup do
    browser_sign_in_as users(:chris)
    @activity = activities(:to_be_closed)
  end

  test "creating a Sign off" do
    visit activity_path(@activity)
    click_on "Close Work Package"

    click_on "Close Workpack"

    assert_text "Sign off was successfully created."
  end

end
