Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks", :sessions => "sessions", :registrations => "registrations" }
  root to: 'static#home'

  resources :users, only: [:show] do
    resources :restaurants
    resources :foods
    get '/manhattan' => 'restaurants#manhattan'
    get '/brooklyn' => 'restaurants#brooklyn'
    get '/queens' => 'restaurants#queens'
    get '/bronx' => 'restaurants#bronx'
    get '/statenisland' => 'restaurants#statenisland'
  end

  resources :restaurant_foods, only: [:destroy]
end
