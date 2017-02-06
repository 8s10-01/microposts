Rails.application.routes.draw do
  get 'sessions/new'

  # get 'users/new'

  root to: 'static_pages#home'
  get 'signup', to: 'users#new'
  
  get 'login' , to: 'session#new'
  get 'login' , to: 'session#create'
  get 'logout' , to: 'session#destroy'
  
  resources :users
end
