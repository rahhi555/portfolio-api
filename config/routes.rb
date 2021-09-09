Rails.application.routes.draw do
  get '/health-check', to: 'health_check#health_check'
  namespace 'api', format: 'json' do
    namespace 'v1' do
      resources 'users', only: %i[index show create]
      resource 'me', only: %i[destroy update], controller: 'users'
      get 'me', to: 'users#me'

      resources 'plans', only: %i[index create destroy show] do
        resources 'roles', only: %i[index create update destroy], shallow: true
        resources 'members', only: %i[index create update destroy], shallow: true
        resources 'maps', only: %i[index create update destroy], shallow: true
      end
    end
  end
end
