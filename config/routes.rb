Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'hosts#new'

  resources :hosts, only: :create
  resources :rooms
end
