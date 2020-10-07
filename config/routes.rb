# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :producers, controllers: {
    confirmations: 'producers/confirmations'
  }
  devise_for :users

  authenticate :user, ->(u) { u.admin? } do
    namespace :admin do
      resources :amaps, only: %i[index new create]
    end
  end

  resources :producers, only: [] do
    get :invitation, on: :collection
    post :invite, on: :collection
  end

  resources :periods, only: %i[new create index show] do
    resources :period_days, only: %i[index create]
  end

  resources :period_days, only: %i[destroy]

  get 'dashboard', to: 'dashboard#home', as: :user_root
  get 'cart', to: 'subscriptions#cart'

  resources :formulas, only: [] do
    resources :subscriptions, only: [] do
      post :add_cart, on: :collection
    end
  end

  resources :subscriptions, only: [:destroy]

  namespace :producer do
    resources :periods, only: %i[index] do
      resources :formulas, only: %i[index new create]
    end

    resources :formulas, only: [:show] do
      resources :delivery_days, only: [] do
        post :present, on: :collection
        post :absent, on: :collection
      end
      get  :copy_formulas_delivery_days, on: :member
      post :copy_formula_delivery_days, on: :member
    end

    root 'dashboard#home'
  end

  get '/', to: 'amaps#index', constraints: { subdomain: 'www' }

  root 'amaps#show'
end
