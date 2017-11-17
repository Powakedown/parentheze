Rails.application.routes.draw do
  resources :guests, only: [:create, :new, :update, :show]

  devise_for :users
  root to: 'pages#home'
  get "/home" => "pages#home"

  # MAIL
  get "/welcome_redirection" => "guests#show"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
