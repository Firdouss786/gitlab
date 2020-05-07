class RedisLogger
  include ActiveModel::Model
  include ActiveModel::Serializers::JSON

  attr_accessor :klass, :document_id, :message, :details

  def save
    Rails.logger.info "RedisLogger: #{self.to_json}"
    REDIS_LOGGER.lpush(logger_key, self.to_json)
  end

  def attributes
    {logged_at: logged_at, klass: @klass, document_id: @document_id, message: @message, details: @details}
  end

  private

    def logger_key
      "#{@klass}:#{@document_id}"
    end

    def logged_at
      Time.now
    end
end
