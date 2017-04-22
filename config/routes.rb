Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks", :sessions => "sessions", :registrations => "registrations" }
  root to: 'static#home'

  resources :users, only: [:show] do
    resources :restaurants
    resources :foods
    get '/manhattan' => 'static#manhattan'
    get '/brooklyn' => 'static#brooklyn'
    get '/queens' => 'static#queens'
    get '/bronx' => 'static#bronx'
    get '/staten_island' => 'static#staten_island'
    get '/outside_nyc' => 'static#outside_nyc'
    get '/under_ten' => 'static#under_ten'
  end

  resources :restaurant_foods, only: [:destroy]
end
