require 'test_helper'

class ManufacturersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @manufacturer = manufacturers(:boeing)
    @duplicate_manufacturer = manufacturers(:airbus)
    sign_in_as users(:chris)
  end

  test "should get index" do
    get manufacturers_url
    assert_response :success
  end

  test "should get new" do
    get new_manufacturer_url
    assert_response :success
  end

  test "should create manufacturer" do
    assert_difference('Manufacturer.count') do
      post manufacturers_url, params: { manufacturer: { name: 'Embraer', description: 'Embraer\'s Description.' } }
    end

    assert_redirected_to manufacturers_url
    follow_redirect!
    assert_select '[data-test-id="error_explanation"]', "Manufacturer was successfully created."
  end

  test "should prevent create of duplicate manufacturer" do
    post manufacturers_url, params: { manufacturer: { name: @manufacturer.name, description: @manufacturer.description } }

    assert_response :success
    assert_select "[data-test-id='error_explanation']", text: "Name has already been taken"
  end

  test "should prevent any duplicate manufacturer name during update" do
    @manufacturer.name = @duplicate_manufacturer.name
    patch manufacturer_url(@manufacturer), params: { manufacturer: { description: @manufacturer.description, name: @manufacturer.name } }

    assert_response :success
    assert_select "[data-test-id='error_explanation']", text: "Name has already been taken"
  end

  test "should show manufacturer" do
    get manufacturers_url(@manufacturer)
    assert_response :success
  end

  test "should get edit" do
    get edit_manufacturer_url(@manufacturer)
    assert_response :success
  end

  test "should update manufacturer" do
    patch manufacturer_url(@manufacturer), params: { manufacturer: { description: @manufacturer.description, name: @manufacturer.name } }
    assert_redirected_to manufacturers_url
    follow_redirect!
    assert_select '[data-test-id="error_explanation"]', "Manufacturer was successfully updated."
  end

  # TODO: Only destroy if there are no associations
  test "should destroy manufacturer" do
    @manufacturer = manufacturers(:manufacturer_delete)

    assert_difference('Manufacturer.count', -1) do
      delete manufacturer_url(@manufacturer)
    end

    assert_redirected_to manufacturers_url
    follow_redirect!
    assert_select '[data-test-id="error_explanation"]', "Manufacturer was successfully destroyed."
  end

  # TODO: Do not destroy if there are any child associations
  test "should prevent destroy of manufacturer" do
    @manufacturer = manufacturers(:boeing)

    delete manufacturer_url(@manufacturer)

    assert_redirected_to manufacturers_url
    follow_redirect!
    assert_select '[data-test-id="error_explanation"]', "Manufacturer has associated AircraftTypes and can not be deleted."
  end

end