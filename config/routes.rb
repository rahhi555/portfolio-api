Rails.application.routes.draw do
  get '/health-check', to: 'health_check#health_check'
end
