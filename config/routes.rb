Rails.application.routes.draw do
  get "dashboard" => "dashboard#index"
  resources :users
  get "register", to: "users#new"
  get "auth/:provider/callback", to: "sessions#create_auth_user"
  resources :sessions, only: [:create]
  get "login", to: "sessions#new"
  get "logout", to: "sessions#destroy"

  root "dashboard#index"
end
