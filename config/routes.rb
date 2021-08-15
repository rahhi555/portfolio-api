Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'users/show'
      get 'users/create'
    end
  end
  get '/health-check', to: 'health_check#health_check'
  namespace 'api', format: 'json' do
    namespace 'v1' do
      resources 'users', only: %i[show create]
    end
  end
end
