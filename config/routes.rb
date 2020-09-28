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

  resources :periods, only: %i[new create index] do
    resources :period_days, only: %i[index create]
  end

  resources :period_days, only: %i[destroy]

  namespace :producer do
    resources :periods, only: %i[index] do
      resources :formulas, only: %i[index new create]
    end

    resources :formulas, only: [:show] do
      resources :delivery_days, only: [] do
        post :present, on: :collection
        post :absent, on: :collection
      end
    end
  end

  root 'application#home'
end
