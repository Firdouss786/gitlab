require 'test_helper'

class SeatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:chris)
  end

  test "should get index" do
    get seats_url(fleets(:B777B))
    assert_select 'h1', "BA B772R-B I5 CONFIG"
  end

  test "should parse Thales lopa file" do
    config = fleets(:B777)

    # First check the fixtures are correct
    get seats_url(config)
    assert_select '.lopa__seat', 229

    # Then check the parser is correct
    thales_lopa_file = fixture_file_upload('test/fixtures/lopa/thales/BA-B772R-B-I5-CONFIG.dat')
    post seats_url(config), params: { file: thales_lopa_file }

    assert_equal 0, config.seats.where(deck: 0).count # Ensure we don't have any stray '0' decks
    assert_equal 229, config.seats.first_deck.count
    assert_equal 0, config.seats.second_deck.count

    assert_equal "A", config.seats.find_by(name: "1A").col
    assert_equal 1, config.seats.find_by(name: "1A").row
    assert_equal "1", config.seats.find_by(name: "1A").travel_class

    assert_equal "C", config.seats.find_by(name: "26C").col
    assert_equal 26, config.seats.find_by(name: "26C").row
    assert_equal "4", config.seats.find_by(name: "26C").travel_class
  end

  test "should parse LTV lopa file" do
    config = fleets(:JBA321)

    # First check the fixtures are correct
    get seats_url(config)
    assert_select '.lopa__seat', 0

    # Then check the parser is correct
    ltv_lopa_file = fixture_file_upload('test/fixtures/lopa/live_tv/AircraftSeatMapLD.xml')
    post seats_url(config), params: { file: ltv_lopa_file }

    assert_equal 0, config.seats.where(deck: 0).count # Ensure we don't have any stray '0' decks
    assert_equal 159, config.seats.first_deck.count
    assert_equal 0, config.seats.second_deck.count

    assert_equal "A", config.seats.find_by(name: "1A").col
    assert_equal 1, config.seats.find_by(name: "1A").row
    assert_equal "1", config.seats.find_by(name: "1A").travel_class

    assert_equal "C", config.seats.find_by(name: "26C").col
    assert_equal 26, config.seats.find_by(name: "26C").row
    assert_equal "4", config.seats.find_by(name: "26C").travel_class
  end

  test "should parse A380 double decker" do
    config = fleets(:A380)

    a380_lopa_file = fixture_file_upload('test/fixtures/lopa/thales/BA-A380-I5-CFG.dat')
    post seats_url(config), params: { file: a380_lopa_file }

    assert_equal 0, config.seats.where(deck: 0).count # Ensure we don't have any stray '0' decks
    assert_equal 259, config.seats.first_deck.count
    assert_equal 212, config.seats.second_deck.count
  end

end
