Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  root to: 'static#home'

  resources :users, only: [:show] do
    resources :restaurants
    resources :foods
  end
end
