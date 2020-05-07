require "application_system_test_case"

class SeatsSelectsTest < ApplicationSystemTestCase

  setup do
    browser_sign_in_as users(:chris)
  end

  # select single seat
  test "has select one seat only" do
    visit seats_url(fleets(:B777))
    find(id: '40F').click
    assert_selector(id: 'lopa_selected_seats', visible: false, text: '40F')
  end

  # select multiple seats/select random seats
  test "has the right number of seats selected" do
    visit seats_url(fleets(:B777))
    find(id: '40F').click
    find(id: '40D').click
    find(id: '40E').click
    assert_selector(id: 'lopa_selected_seats', visible: false, text: '40D, 40E, 40F')
  end

  # select multiple seats decending order
  test "select multiple seats decending order" do
    visit seats_url(fleets(:B777))
    find(id: '15A').click
    find(id: '14B').click
    find(id: '13D').click
    find(id: '12E').click
    find(id: '11F').click
    find(id: '10G').click
    assert_selector(id: 'lopa_selected_seats', visible: false, text: '10G, 11F, 12E, 13D, 14B, 15A')
  end

  # select multiple seats ascending order
  test "select multiple seats ascending order" do
    visit seats_url(fleets(:B777))
    find(id: '10A').click
    find(id: '11B').click
    find(id: '12D').click
    find(id: '13E').click
    find(id: '14F').click
    find(id: '15G').click
    assert_selector(id: 'lopa_selected_seats', visible: false, text: '10A, 11B, 12D, 13E, 14F, 15G')
  end

  test "select and deselect all seats" do
    visit seats_url(fleets(:B777))
    find(id: 'select_all_seats').click
    assert_selector(id: 'lopa_selected_seats', visible: false, text: '1A, 1E, 1F, 1K, 2A, 2E, 2F, 2K, 3A, 3K, 4A, 4E, 4F, 4K, 10A, 10B, 10D, 10E, 10F, 10G, 10J, 10K, 11A, 11B, 11D, 11E, 11F, 11G, 11J, 11K, 12A, 12B, 12D, 12E, 12F, 12G, 12J, 12K, 13A, 13B, 13D, 13E, 13F, 13G, 13J, 13K, 14A, 14B, 14D, 14E, 14F, 14G, 14J, 14K, 15A, 15B, 15D, 15E, 15F, 15G, 15J, 15K, 21A, 21B, 21D, 21E, 21F, 21G, 21J, 21K, 22A, 22B, 22D, 22E, 22F, 22G, 22J, 22K, 23A, 23B, 23D, 23E, 23F, 23G, 23J, 23K, 24A, 24B, 24D, 24E, 24F, 24G, 24J, 24K, 25A, 25B, 25D, 25E, 25F, 25G, 25J, 25K, 26A, 26B, 26C, 26D, 26E, 26F, 26H, 26J, 26K, 27A, 27B, 27C, 27D, 27E, 27F, 27H, 27J, 27K, 28A, 28B, 28C, 28D, 28E, 28F, 28H, 28J, 28K, 29A, 29B, 29C, 29D, 29E, 29F, 29H, 29J, 29K, 30A, 30B, 30C, 30D, 30E, 30F, 30H, 30J, 30K, 31A, 31B, 31C, 31D, 31E, 31F, 31H, 31J, 31K, 32A, 32B, 32C, 32D, 32E, 32F, 32H, 32J, 32K, 33A, 33B, 33C, 33D, 33E, 33F, 33H, 33J, 33K, 34A, 34B, 34C, 34D, 34E, 34F, 34H, 34J, 34K, 35A, 35B, 35C, 35D, 35E, 35F, 35H, 35J, 35K, 36A, 36B, 36C, 36D, 36E, 36F, 36H, 36J, 36K, 37A, 37B, 37C, 37D, 37E, 37F, 37H, 37J, 37K, 38A, 38B, 38C, 38D, 38E, 38F, 38H, 38J, 38K, 39A, 39B, 39D, 39E, 39F, 39J, 39K, 40D, 40E, 40F')
    find(id: 'deselect_all_seats').click
    assert_selector(id: 'lopa_selected_seats', visible: false, text: '')
  end

  test "Select single seat and multiple seats and deselect some seats" do
    visit seats_url(fleets(:B777))
    # select single seats
    find(id: '40F').click
    assert_selector(id: 'lopa_selected_seats', visible: false, text: '40F')
    #select multiple seats with above selected seats
    find(id: '10J').click
    find(id: '1A').click
    find(id: '2E').click
    find(id: '3K').click
    find(id: '10K').click
    assert_selector(id: 'lopa_selected_seats', visible: false, text: '1A, 2E, 3K, 10J, 10K, 40F')
    # deselect some seats
    find(id: '2E').click
    find(id: '3K').click
    assert_selector(id: 'lopa_selected_seats', visible: false, text: '1A, 10J, 10K, 40F')
  end
end
