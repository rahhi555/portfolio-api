Rails.application.routes.draw do
  get '/health-check', to: 'health_check#health_check'
  namespace 'api' do
    namespace 'v1' do
      resources 'users'
    end
  end
end
