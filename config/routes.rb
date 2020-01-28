Rails.application.routes.draw do
  # get 'comments/new'
  # post 'comments/create'
  # get 'comments/edit'
  # post 'comments/update'

  devise_for :users
  
  resources :posts
  resources :comments
  resources :likes, only: %i[index create destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'posts#index'
  
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    get '/users' => 'users#index'
  end

  get '/user/:id', to: 'users#show', as: 'user'
  resources :friendships, only: %i[create destroy]
  # get '/profile/:id/update', to: 'users#edit', as
end
