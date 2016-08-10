Rails.application.routes.draw do

  resources :user_sessions, only: [:new, :create, :destroy]

  get 'edit_profile', to: 'users#edit', as: :edit_profile
  patch 'update_profile', to: 'users#update', as: :update_profile

  resources :customers do
    get :search, on: :collection
  end

  resources :vehicles do
    resources :attachments, only: [:create]
    get 'publish', on: :member
    post 'prepare_to_publish', on: :member, as: :prepare_to_publish
  end

  resources :expenses
  resources :expense_categories do
    get :search, on: :collection
  end

  resources :attachments, only: [:destroy]
  resources :brands
  resources :vehicle_models do
    get :search, on: :collection
  end

  resources :versions, only: [:index, :create]
  resources :coincidences, except: [:edit, :new]
  resources :buyers
  resources :budgets
  resources :sales do
    get 'pre_print_advance_certificate', on: :member
    get 'pre_print_sale_certificate', on: :member
  end

  post 'print_pdf', to: 'printer#print_pdf'

  get 'login', to: 'user_sessions#new', as: :login
  post 'logout', to: 'user_sessions#destroy', as: :logout

  root 'vehicles#index'
end
