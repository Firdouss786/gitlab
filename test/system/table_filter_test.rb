require "application_system_test_case"

class TableFilterTest < ApplicationSystemTestCase

  setup do
    browser_sign_in_as users(:chris)
    REDIS.flushdb
    airports.each { |i| Search::Index.new( klass: i.class.name, id: i.id, index_string: i.searchable_attributes.join(' ')).perform }
  end

  teardown do
    REDIS.flushdb
  end

  test "filter should return correct number of rows" do
    visit airports_path

    click_on "Filter List"
    fill_in "q", with: "ch\n"

    assert_selector('div.table label', count: 3)
  end

  test "filter should suggest links if no rows found" do
    visit airports_path

    click_on "Filter List"
    fill_in "q", with: "abc\n"

    assert_selector 'h2', text: "Found no airports."
    assert_selector 'p', text: "Clear Filters or Try adding new airport"
  end

end
