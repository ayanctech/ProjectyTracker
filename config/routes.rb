Rails.application.routes.draw do


  resources :projects do
    resources :comments, shallow: true
    resources :features, shallow: true do
      resources :tasks, shallow: true
    end
  end



  root "users#index"
  resources :users do
    member do
      get :confirm_email
    end
  end
  resources :sessions

  # Add route for OmniAuth callback
  match '/auth/:provider/callback', to: 'auth#callback', via: [:get, :post]
  get 'auth/signin'
  get 'auth/signout'
  #get "signup", to: "users#new", as: "signup"
  #get "login", to: "sessions#new", as: "login"
  #get "logout", to: "sessions#destroy", as: "logout"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
