require 'test_helper'

class ApidocsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:chris) 
  end

  test "should get index" do
    get apidocs_url
    assert_response :success
  end

end
