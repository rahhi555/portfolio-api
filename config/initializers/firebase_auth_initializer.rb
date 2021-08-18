FirebaseIdToken.configure do |config|
  config.redis = Redis.new(host: Rails.env.production? ? Rails.application.credentials.redis[:host] : 'redis',
                           db: 15)
  config.project_ids = ['minimap-dadd2']
end
