Rails.application.routes.draw do


  resources :projects do
    resources :comments
    resources :features
  end

  resources :features do
    resources :tasks
    resources :notifications
  end

  resources :comments do
    resources :notifications
  end

  root "projects#index"
  
  resources :users do
    member do
      get :confirm_email
    end
  end
  resources :sessions

  # Add route for OmniAuth callback
  match "/auth/:provider/callback", to: "auth#callback", via: [:get, :post]
  get "auth/signin"
  get "auth/signout"

  mount ActionCable.server => "/cable"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
