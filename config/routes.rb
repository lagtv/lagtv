Lagtv::Application.routes.draw do
  root :to => 'home#index'  

  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :sessions
  match '/auth/:provider/callback' => 'sessions#create'
  match '/auth/:provider/failure', :to => 'sessions#failure'

end
