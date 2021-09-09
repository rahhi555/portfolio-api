Rails.application.routes.draw do
  get '/health-check', to: 'health_check#health_check'
  namespace 'api', format: 'json' do
    namespace 'v1' do
      resources 'users', only: %i[index show create]
      resource 'me', only: %i[destroy update], controller: 'users'
      get 'me', to: 'users#me'

      resources 'plans', only: %i[index create destroy show], shallow: true do
        resources 'roles', only: %i[index create update destroy]
        resources 'members', only: %i[index create update destroy]
        resources 'maps', only: %i[index create update destroy] do
          resources 'rects', controller: 'svgs', type: 'rects', only: %i[index create update destroy]
          resources 'paths', controller: 'svgs', type: 'paths', only: %i[index create update destroy]
          resources 'polylines', controller: 'svgs', type: 'polylines', only: %i[index create update destroy]
        end
      end
    end
  end
end
