Rails.application.routes.draw do

  devise_for :users, path: 'auth', defaults: { format: :json }, controllers: {
      registrations: 'users/registrations'
  }

  resources :users
  resources :customers
end
