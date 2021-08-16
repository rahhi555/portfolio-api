FirebaseIdToken.configure do |config|
  config.redis = Redis.new(host: ENV.fetch("RAILS_REDIS_HOST") { 'redis' }, db: 15)
  config.project_ids = ['minimap-dadd2']
end
