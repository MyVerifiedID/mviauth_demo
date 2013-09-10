Rails3MongoidDevise::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end

  root :to => "home#index"
  devise_for :users
  resources :users

  match "logout" => "sessions#destroy"

  match '/auth/:provider/callback' => 'sessions#create'
  match 'auth/failure', to: redirect('/')

end