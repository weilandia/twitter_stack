Rails.application.routes.draw do
  root 'static_pages#home'
  get '/auth/twitter', as: :login
  get '/auth/twitter/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: :logout
  resources :users, param: :screen_name, only: [:show]
  get '/search', as: :user_search, to: 'users#search'
end
