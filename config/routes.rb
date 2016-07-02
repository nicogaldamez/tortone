Rails.application.routes.draw do

  resources :user_sessions, only: [:new, :create, :destroy]

  get 'edit_profile', to: 'users#edit', as: :edit_profile
  patch 'update_profile', to: 'users#update', as: :update_profile

  resources :customers

  get 'login', to: 'user_sessions#new', as: :login
  post 'logout', to: 'user_sessions#destroy', as: :logout

  root 'main#index'
end
