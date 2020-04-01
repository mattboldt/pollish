Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'application#index'

  namespace :api do
    resources :users, only: %i(create update)
    resources :rooms
    resources :polls
    resources :voters
  end

  match "*path", to: "application#index", via: :all
end
