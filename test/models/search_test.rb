require 'test_helper'

class SearchTest < ActiveSupport::TestCase

  setup do
    REDIS.flushdb

    users.each do |i|
      Search::Index.new(klass: i.class.name, id: i.id, index_string: "#{i.email} #{i.full_name}").perform
    end
  end

  teardown do
    REDIS.flushdb
  end

  test "should return chris" do
    results = Search.new(text: "Chris Swann").perform

    assert_equal 1, results.count
    assert_equal "Chris", results.first.document.first_name
  end

  test "should return chris (with klass)" do
    results = Search.new(text: "Chris Swann", klass: "user").perform

    assert_equal 1, results.count
    assert_equal "Chris", results.first.document.first_name
  end

  test "should NOT return chris (with incorrect klass)" do
    results = Search.new(text: "Chris Swann", klass: "wrong_klass").perform

    assert_equal 0, results.count
  end

  test "should return maaz" do
    results = Search.new(text: "Maaz").perform

    assert_equal 1, results.count
    assert_equal "Maaz", results.first.document.first_name
  end

  test "should return partial match" do
    results = Search.new(text: "Kath").perform

    assert_equal 1, results.count
    assert_equal "Katherine", results.first.document.first_name
  end
end
