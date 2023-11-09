Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :guesthouses, only: [:show, :new, :create, :edit, :update] do
    resources :rooms, only: [:index, :show, :new, :create, :edit, :update]
  end
end
