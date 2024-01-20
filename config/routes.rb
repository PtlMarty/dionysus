Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :services do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, only: [:index, :show, :destroy] do
    member do
      patch :accept
      patch :decline
    end
  end

  resources :users, only: [:show, :edit, :update, :destroy] do
    resources :services, only: [:index, :show], dependant: :destroy
  end
end
