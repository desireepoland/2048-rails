Rails.application.routes.draw do
  root "site#index"
  get '/auth/:provider/callback', to: 'sessions#create'
end
