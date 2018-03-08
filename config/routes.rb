# frozen_string_literal: true

Rails.application.routes.draw do

  resources :guests, only: %i[create new update show index]

  # VITRINE
  root "pages#home"
  patch "/home", to: "pages#update"
  get "/contact", to: "pages#contact"
  get "/pourquoi_parentheze", to: "pages#why"

  # MAIL
  get '/welcome', to: 'guests#welcome'

  # INSCRIPTION
  devise_for :users, :controllers => { :registrations => "my_registrations" }

  resources :users, only: %i[] do
    resources :profiles, only: %i[new create show edit update] do
      member do
        get 'previous'
        get 'validate'
        get 'request_update'
      end
    end
  end

  #JOBS
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # ADMIN
  get '/admin', to: 'admins#password_check'
  get '/admin/password_verification', to: 'admins#password_verification'
  get '/admin/validations', to: 'admins#validations'

  mount Attachinary::Engine => "/attachinary"

end
