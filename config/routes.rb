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
  resources :users do
    resources :profiles, only: %i[new create show update] do
      member do
        get 'previous'
      end
    end
    resources :preprofiles, only: %i[create update]
  end

  mount Attachinary::Engine => "/attachinary"

end
