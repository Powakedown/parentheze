# frozen_string_literal: true

Rails.application.routes.draw do

  resources :guests, only: %i[create new update show index]

  # VITRINE
  root "pages#home"
  patch "/home", to: "pages#update"
  get "/pourquoi_parentheze", to: "pages#why"

  # MESSENGER
  get '/welcome', to: 'guests#welcome'
  get "/contact", to: "messengers#contact"
  get "/mini_contact", to: "messengers#mini_contact"
  get "/add_friend", to: "messengers#add_friend"
  get "/ask_for_cards", to: "messengers#ask_for_cards"
  get "/custom_mail", to: "messengers#custom_mail"
  get "/card_for_school", to: "messengers#card_for_school"


  # INSCRIPTION
  devise_for :users, controllers: { registrations: "my_registrations" }

  get '/profiles', to: "profiles#index"

  resources :users, only: %i[] do
    resources :profiles, only: %i[new create show edit update destroy] do
      member do
        get 'previous'
        get 'validate'
        get 'request_update'
        get 'add_friends'
        get 'ask_for_cards'
        get 'card_for_school'
      end
    end
  end

  #JOBS
  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # ADMIN
  namespace :admin do
    get '/', to: 'admins#password_check'
    get '/requested', to: 'admins#requested'
    get '/validations', to: 'admins#validations'
    get '/password_verification', to: 'admins#password_verification'
    get '/destroy_profile', to: 'admins#destroy_profile'
    get '/mailer', to: 'admins#mailer'
    resources :letters, only: %i[index update destroy] do
      member do
        get 'export'
      end
    end
  end

  mount Attachinary::Engine => "/attachinary"

end
