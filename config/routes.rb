Rails.application.routes.draw do

  devise_for :users, defaults: { format: :json }, controllers: {
      registrations: 'users/registrations',
      sessions: 'users/sessions',
  }

  resources :users
  resources :customers
end
