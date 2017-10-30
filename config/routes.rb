Rails.application.routes.draw do
  resources :guests, only: [:create]

  devise_for :users
  root to: 'pages#home'
  get "/home" => "pages#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
