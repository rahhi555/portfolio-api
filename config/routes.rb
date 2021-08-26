Rails.application.routes.draw do
  get '/health-check', to: 'health_check#health_check'
  namespace 'api', format: 'json' do
    namespace 'v1' do
      resources 'users', only: %i[index show create]
      get 'me', to: 'users#me'
      delete 'users', to: 'users#destroy'
      patch 'users', to: 'users#update'
    end
  end
end
