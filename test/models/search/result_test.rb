require 'test_helper'

class Search::ResultTest < ActiveSupport::TestCase
  setup do
    @user = users(:chris)
    @search_result = Search::Result.new(search_string: "Chris Swann", redis_set: "User:#{@user.id}")
  end

  test "should build a result" do
    assert_equal "Chris Swann", @search_result.search_string
    assert_equal "User", @search_result.document_name
    assert_equal @user, @search_result.document
  end
end
