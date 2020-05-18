Rails.application.routes.draw do
  root 'home#index'

  resources :home, only: [:index]
  resources :users, only: [:index, :edit, :new, :create, :update, :destroy]

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create', as: 'sessions'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  post '/keys/generate', to: 'keys#generate'

  get '/services/ping', to: "services#ping"
end
