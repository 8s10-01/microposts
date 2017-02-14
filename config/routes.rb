Rails.application.routes.draw do
  root to: 'static_pages#home' # app/views/static_pages/home.html.erbの内容がトップページに表示
  get    'signup', to: 'users#new'
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get     '/users/:id/followings', to: 'users#followings', as: :followings_user
  get     '/users/:id/followers', to: 'users#followers', as: :followers_user
  
  resources :users
  resources :microposts
  resources :relationships, only: [:create, :destroy]
end
