require "application_system_test_case"

class ModalFilterTest < ApplicationSystemTestCase

  setup do
    browser_sign_in_as users(:chris)
  end

  test "filter should return correct number of list items" do
    visit airports_path

    find('#jump-menu-modal-container').click
    fill_in "modal_search", with: "air"

    assert_selector('div#modal a', count: 2)
  end

end
