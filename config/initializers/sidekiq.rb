Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://:8QmFEGp2KHnJYZi3fpAiv55hO4Yd5LiumftmKMB6yqc=@testredis-cache.redis.cache.windows.net:6379' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://:8QmFEGp2KHnJYZi3fpAiv55hO4Yd5LiumftmKMB6yqc=@testredis-cache.redis.cache.windows.net:6379' }
end
