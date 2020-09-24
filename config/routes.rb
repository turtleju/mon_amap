# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :producers
  devise_for :users

  authenticate :user, ->(u) { u.admin? } do
    namespace :admin do
      resources :amaps, only: %i[index new create]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'application#home'
end
