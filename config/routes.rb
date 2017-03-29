Rails.application.routes.draw do

  devise_for :users, path: 'auth', defaults: { format: :json }

  resources :users
  resources :customers
end
