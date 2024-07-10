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

  resources :users do
    member do
      get :following, :followers
    end
  end
  
  resources :photos
  resources :albums
end