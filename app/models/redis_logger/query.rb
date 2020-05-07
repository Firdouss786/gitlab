class RedisLogger::Query
  include ActiveModel::Model

  attr_accessor :klass, :document_id

  def perform
    REDIS_LOGGER.lrange("#{@klass}:#{@document_id}", 0, 19).map do |result|
      result = JSON.parse(result)

      RedisLogger::Result.new(
        logged_at: result["logged_at"],
        klass: result["klass"],
        document_id: result["document_id"],
        message: result["message"],
        details: result["details"]
      )
    end
  end

end


class RedisLogger::Result
  include ActiveModel::Model

  attr_accessor :logged_at, :klass, :document_id, :message, :details

  def initialize(logged_at:, klass:, document_id:, message:, details:)
    @logged_at = logged_at
    @klass = klass
    @document_id = document_id
    @message = message
    @details = {} || details
  end
end
