Rails.application.routes.draw do
  resources :rentals
  resources :comments do
    member do
      post :new
    end
  end
  resources :products

  devise_for :users

  get "profile/:id", to: "profile#profile", as: "profile"
  get "profile/:id/rentals", to: "profile#rentals", as: "profile_rentals"
  post "rental/done/:id", to: "rentals#set_done", as: "rental_done"
  post "like/:rental_id", to: "like#create", as: "like"
  post "dislike/:rental_id", to: "dislike#create", as: "dislike"

  # Defines the root path route ("/")
  root "products#index"
end
