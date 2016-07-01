Rails.application.routes.draw do

  resources :user_sessions, only: [:new, :create, :destroy]
  resources :users, only: [:edit, :update]

  resources :customers

  get 'login', to: 'user_sessions#new', as: :login
  post 'logout', to: 'user_sessions#destroy', as: :logout

  root 'main#index'
end
