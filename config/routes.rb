Lagtv::Application.routes.draw do
  root :to => 'home#index'  
  resources :sessions
  resources :users
  match '/auth/:provider/callback' => 'sessions#create'
end
