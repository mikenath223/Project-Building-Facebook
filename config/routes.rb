Rails.application.routes.draw do

  get '/messagerequest/:id', to: 'chatmessages#message_request', as: 'message_request'
  resources :chatmessages

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }

  resources :posts
  resources :comments
  resources :likes, only: %i[index create destroy]

  root to: 'posts#index'
  
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    get '/users' => 'users#index'
  end

  get '/user/:id', to: 'users#show', as: 'user'
  resources :friendships, only: %i[create destroy]
  get 'notifications', to: 'friendships#create_notification', as: 'notifications'
  post 'acceptrequest', to: 'friendships#accept_request', as: 'accept'
  get 'friends', to: 'friendships#friends', as: 'friends'
  delete 'deletefriend', to: 'friendships#delete', as: 'delete_friend'
end
