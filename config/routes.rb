Rails.application.routes.draw do
  get '/list',     to: 'books#list'
  get '/show',     to: 'books#show'
  get '/new',      to: 'books#new'
  get '/index',      to: 'static_pages#index'
  get 'sessions/new'
  root 'static_pages#home'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :books
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
