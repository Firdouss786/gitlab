require 'test_helper'

class Search::IndexTest < ActiveSupport::TestCase
  setup do
    @search_index = Search::Index.new(klass: "User", id: 1, index_string: "Chris Swann")
  end

  test "should build index set" do
    assert_equal ["ch", "chr", "chri", "chris", "sw", "swa", "swan", "swann"], @search_index.index_set
  end

  test "should build document identifier" do
    assert_equal "User:1", @search_index.document_identifier
  end

  test "should expose document klass" do
    assert_equal "User", @search_index.klass
  end
end
