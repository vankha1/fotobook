Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
  }
  root "photos#index"
  get '/login', to: "auths#login"
  get '/signup', to: "auths#signup"

  resources :photos
  resources :albums
end