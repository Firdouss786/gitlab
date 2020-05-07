require 'test_helper'

class RedisLoggerTest < ActiveSupport::TestCase
  setup do
    @user = users(:chris)
    @logger = RedisLogger.new({klass: "User", document_id: @user.id, message: "#{@user.email} authenticated.", details: @user.as_json})
  end

  teardown do
    REDIS_LOGGER.flushdb
  end

  test "logger builds json" do
    assert_equal @user.id, @logger.as_json["document_id"]
  end
end
