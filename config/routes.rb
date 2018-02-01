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
      end
    end
  end

  mount Attachinary::Engine => "/attachinary"

end
