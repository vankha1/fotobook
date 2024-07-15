Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
  }
  root "photos#photo_feeds"
  get "/discover/photos", to: "photos#discover"
  get "/discover/albums", to: "albums#discover"

  get "/users/:id/photos", to: "users#show"
  get "/users/:id/albums", to: "users#show"
  get "/users/:id/followings", to: "users#show_follow"
  get "/users/:id/followers", to: "users#show_follow"


  # resources :users, only: [:index, :show] do
  #   resources :albums, only: [:index, :show, :new, :create] do
  #     resources :photos, only: [:new, :create]
  #   end
  # end

  # resources :users, only: [:index, :show] do
  #   resources :photos
  # end

  # resources :users do
  #   member do
  #     get :following, :followers
  #   end
  # end
  
  resources :users
  resources :photos
  resources :albums
  resources :follows, only: [:create, :destroy]
  # post "/reactions/:photo_id", to: "photos_reactions#create"
  # delete "/reactions/:photo_id", to: "photos_reactions#destroy"
  resources :photos_reactions, only: [:create, :destroy]
  resources :albums_reactions, only: [:create, :destroy]
end