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

  resources :expenses
  resources :expense_categories do
    get :search, on: :collection
  end

  resources :attachments, only: [:destroy]
  resources :brands, only: [:create]
  resources :vehicle_models, only: [:index, :create] do
    get :search, on: :collection
  end
  
  resources :versions, only: [:index, :create]
  resources :coincidences, except: [:edit, :new]
  resources :buyers
  resources :budgets

  get 'login', to: 'user_sessions#new', as: :login
  post 'logout', to: 'user_sessions#destroy', as: :logout

  root 'main#index'
end
