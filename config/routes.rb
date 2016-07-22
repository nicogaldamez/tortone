Rails.application.routes.draw do

  resources :user_sessions, only: [:new, :create, :destroy]

  get 'edit_profile', to: 'users#edit', as: :edit_profile
  patch 'update_profile', to: 'users#update', as: :update_profile

  resources :customers do
    get :search, on: :collection
  end
  resources :vehicles do
    resources :attachments, only: [:create]
  end
  resources :attachments, only: [:destroy]
  resources :brands, only: [:create]
  resources :vehicle_models, only: [:index, :create]
  resources :versions, only: [:index, :create]
  resources :buyers

  get 'login', to: 'user_sessions#new', as: :login
  post 'logout', to: 'user_sessions#destroy', as: :logout

  root 'main#index'
end
