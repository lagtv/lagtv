Lagtv::Application.routes.draw do
  mount Forem::Engine, :at => "/forums"
  root :to => 'home#index'  

  get 'login', to: 'sessions#create', as: 'login'
  get 'register', to: 'users#new', as: 'register'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  match "/my_profile" => "users#edit", :as => :my_profile

  resources :sessions
  resources :password_reset
  resources :users
  resources :replays do
    resources :comments

    collection do
      get 'download'
      get 'bulk_update'
    end
  end
end
