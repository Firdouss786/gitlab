require 'test_helper'

class BomUploadsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in_as users(:chris)
    @fleet = fleets(:B777)
  end

  test "should get new" do
    get new_bom_upload_path(@fleet)
    assert_response :success
  end

end
