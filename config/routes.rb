Rails.application.routes.draw do
  
  resources :reviews
  resources :teas
  resources :brands, only: [:index, :new, :create]

  
  root to: 'welcome#show'

  #signup
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  #login
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  
  #logout
  delete '/logout', to: 'sessions#destroy'

  #omni
  get '/auth/:provider/callback', to: 'sessions#omniauth'

  #resources
  resources :users
 
end