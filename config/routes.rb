Rails.application.routes.draw do
  resources :comments do
    member do
      post :new
    end
  end
  resources :products

  devise_for :users

  # Defines the root path route ("/")
  root "products#index"
end
