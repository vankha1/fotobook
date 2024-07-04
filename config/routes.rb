Rails.application.routes.draw do
  root "photos#index"
  get '/login', to: "auths#login"
  get '/signup', to: "auths#signup"

  resources :photos
  resources :albums
end