Rails.application.routes.draw do
  get '/health-check', to: 'health_check#health_check'
  namespace 'api', format: 'json' do
    namespace 'v1' do
      resources 'users', only: %i[show create]
    end
  end
end
