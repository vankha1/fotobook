Rails.application.routes.draw do
  root "photos#index"
  get '/login', to: "auths#login"
  get '/signup', to: "auths#signup"

  namespace :feeds do
    resources :photos, :albums
  end
end