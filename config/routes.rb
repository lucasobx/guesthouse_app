Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :guesthouses, only: [:show, :new, :create]
end
