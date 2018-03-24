Rails.application.routes.draw do
  resources :users
  resources :books

  get    'sessions/index'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  get    '/sell',    to:  'books#new'
  post   '/login',   to: 'sessions#create'
  post   '/sell',    to: 'books#create'
  delete '/logout',  to: 'sessions#destroy'


  root 'sessions#index'

end
