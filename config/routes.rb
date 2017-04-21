Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks", :sessions => "sessions", :registrations => "registrations" }
  root to: 'static#home'

  resources :users, only: [:show] do
    resources :restaurants
    resources :foods
    get '/under_ten' => 'restaurant_foods#under_ten'
  end

  resources :restaurant_foods, only: [:destroy]
end
