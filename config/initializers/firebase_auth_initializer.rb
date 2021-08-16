FirebaseIdToken.configure do |config|
  config.redis = Redis.new(host: '172.17.0.2')
  config.project_ids = ['minimap-dadd2']
end
