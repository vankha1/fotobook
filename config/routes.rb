Rails.application.routes.draw do
  root "photos#index"
  devise_for :users
  get '/login', to: "auths#login"
  get '/signup', to: "auths#signup"

  resources :photos
  resources :albums
end