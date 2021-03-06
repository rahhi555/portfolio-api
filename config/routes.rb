Rails.application.routes.draw do
  get '/health-check', to: 'health_check#health_check'
  namespace 'api', format: 'json' do
    namespace 'v1' do
      resources 'users', only: %i[index show create]
      resource 'me', only: %i[destroy update], controller: 'users'
      get 'me', to: 'users#me'

      resources 'plans', only: %i[index create destroy show update], shallow: true do
        get 'svgs', to: 'svgs#index'
        resources 'roles', only: %i[index create update destroy]
        resources 'members', only: %i[index create update destroy]
        resources 'maps', only: %i[index create update destroy] do
          resources 'svgs', only: %i[create update destroy]
        end
        resources 'todo_lists', only: %i[index create update destroy] do
          resources 'todos', only: %i[index create update destroy show]
        end
        resources 'todo_statuses', only: [:index]
      end
    end
  end
end
