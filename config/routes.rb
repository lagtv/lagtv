Lagtv::Application.routes.draw do
  mount Forem::Engine, :at => "/forums"
  root :to => 'pages#home'  

  get 'login', to: 'sessions#new', as: 'login'
  get 'register', to: 'users#new', as: 'register'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  match "/my_profile" => "users#edit", :as => :my_profile
  match "/about" => "pages#about", :as => :about

  resources :sessions
  resources :password_reset
  resources :users do
    resources :replays do
      collection do
        get 'page', :to => 'replays#user_page'
      end
    end
  end

  resources :replays do
    resources :comments

    collection do
      get 'download'
      get 'bulk_update'
    end
  end
end
