Lagtv::Application.routes.draw do
  root :to => 'home#index'  
  resources :sessions
  match '/auth/:provider/callback' => 'sessions#create'
end
