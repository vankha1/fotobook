Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
  }
  root "photos#index", is_active: true
  get "/my-photo", to: "photos#new", is_active: true

  resources :photos
  resources :albums
end