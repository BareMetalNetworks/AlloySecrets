require 'redis'
require 'redis-namespace'
require 'redis-search'

redis = Redis.new(:host => '10.0.1.17', :port => '6379')

redis.select(3)

redis = Redis::Namespace.new("alloysecrets:redis_search", :redis => redis)

redis = Redis::Search.configure do |config|
  config.redis = redis
  config.complete_max_length = 10000
 # config.disable_remmesg = false
end