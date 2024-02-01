Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :services do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, only: [:index, :show, :update, :destroy] do
    member do
      patch :accept
      patch :rejected
    end
  end

  resources :users, only: [:show, :edit, :update, :destroy] do
    resources :services, only: [:new, :index, :show], dependant: :destroy
  end
end
