Rails.application.routes.draw do

  scope module: :v1, constraints: APIConstraints.new(1, true) do
    resources :users
    resources :customers
    resources :reservoir_groups
    resources :reservoirs
  end

  devise_for :users,
    defaults: { format: :json },
    failure_app: 'CustomFailure',
    skip: [:registrations, :passwords, :confirmations, :sessions]
  devise_scope :user do
    # Registration
    post '/users', :to => 'users/registrations#create', :as => nil, format: :json
    put '/users', :to => 'users/registrations#update', :as => nil, format: :json
    delete '/users', :to => 'users/registrations#destroy', :as => nil, format: :json
    # Confirmation
    get '/users/confirmation', :to => 'users/confirmations#show', :as => :user_confirmation, format: :json
    # Password
    post '/users/password', :to => 'users/passwords#create', :as => nil, format: :json
    put '/users/password', :to => 'users/passwords#update', :as => nil, format: :json
    # Confirmation
    post '/users/confirmation', :to => 'users/confirmations#create', :as => nil, format: :json
    # Session
    post '/users/sign_in', :to => 'users/sessions#create', :as => :user_session, format: :json
    delete '/users/sign_out', :to => 'users/sessions#destroy', :as => :destroy_user_session, format: :json
  end

end
