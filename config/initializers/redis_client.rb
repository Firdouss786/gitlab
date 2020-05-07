REDIS = Redis.new(url: Rails.application.config.redis)
REDIS_COUNTER = Redis.new(url: Rails.application.config.redis_counter)
REDIS_LOGGER = Redis.new(url: Rails.application.config.redis_logger)
