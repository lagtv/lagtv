Lagtv::Application.routes.draw do
  root :to => 'home#index'  

  get 'login', to: 'sessions#create', as: 'login'
  get 'register', to: 'users#new', as: 'register'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :sessions
  resources :password_reset
  resources :users
end
