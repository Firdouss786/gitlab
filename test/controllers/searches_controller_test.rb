require 'test_helper'

class SearchesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:chris)
    sign_in_as @user
  end

  test "should get index" do
    get search_index_path
    assert_response :success
  end

  test "should create search" do
    REDIS.flushdb
    users.each { |i| Search::Index.new(klass: i.class.name, id: i.id, index_string: "#{i.email} #{i.full_name}").perform }

    post search_index_path, params: { search: { text: @user.first_name } }
    assert_select ".search-results-grid span.search-result__heading", text: @user.full_name
  end

end
