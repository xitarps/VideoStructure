Rails.application.routes.draw do
  resources :play_backs
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'pages#index'

  post 'count', to: 'counters#count'
end
