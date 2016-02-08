Rails.application.routes.draw do
  root "site#index"
  get '/auth/:provider/callback', to: 'sessions#create'
  get "/login" => "sessions#new", as: :login
  delete "/logout/" => "sessions#destroy", as: :logout
end
