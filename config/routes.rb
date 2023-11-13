Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'home#index'
  resources :guesthouses, only: [:show, :new, :create, :edit, :update] do
    resources :rooms, only: [:index, :show, :new, :create, :edit, :update] do
      resources :period_prices, only: [:new, :create, :edit, :update, :destroy]
      get :manage_period_prices, on: :member
    end
  end
end
