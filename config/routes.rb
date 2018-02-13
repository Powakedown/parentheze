# frozen_string_literal: true

Rails.application.routes.draw do
  root "pages#home"
  resources :guests, only: %i[create new update show index]

  devise_for :users

  get "/home", to: "pages#home"
  patch "/home", to: "pages#update"
  get "/pourquoi_parentheze", to: "pages#why"

  # MAIL
  get '/welcome', to: 'guests#welcome'

  # INSCRIPTION
  resources :users, only: %i[] do
    resources :profiles, only: %i[new create show edit update] do
      member do
        get 'previous'
        get 'validate'
        get 'request_update'
      end
    end
  end

  # ADMIN
  get '/admin', to: 'admins#password_check'
  get '/admin/password_verification', to: 'admins#password_verification'
  get '/admin/validations', to: 'admins#validations'

  mount Attachinary::Engine => "/attachinary"

end
