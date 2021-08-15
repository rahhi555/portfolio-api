FirebaseIdToken.configure do |config|
  config.redis = Redis.new
  config.project_ids = ['minimap-dadd2']
end