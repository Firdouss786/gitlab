require 'test_helper'

class ConfigFileControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in_as users(:chris)
  end

  test "should upload seat.dat file and verify upload of file in ActiveStorage" do
		# First check for ActiveStorage upload for a seat.dat file
		seat_dat = fixture_file_upload('test/fixtures/lopa/thales/BA-B772R-B-I5-CONFIG.dat')
    post seats_url(fleets(:B777)), params: {file: seat_dat}

    # Assert uploaded file exists in ActiveStorage.
		assert_not_nil(fleets(:B777).config_file.config_file_payload)

		# Secondly check for ActiveStorage upload for a seat.xml file
		seat_xml = fixture_file_upload('test/fixtures/lopa/live_tv/AircraftSeatMapA320.xml')
    post seats_url(fleets(:B777B)), params: {file: seat_xml}

    # Assert uploaded file exists in ActiveStorage.
		assert_not_nil(fleets(:B777B).config_file.config_file_payload)
  end
end
