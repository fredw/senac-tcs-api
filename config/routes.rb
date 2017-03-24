Rails.application.routes.draw do

  #devise_for :users, path: 'auth', defaults: { format: :json }
  mount_devise_token_auth_for 'User', at: 'auth'

  resources :users

end
