Rails.application.routes.draw do

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

  resources :reviews
  resources :teas
  resources :brands, only: [:index, :new, :create]

  resources :users, only: [:show] 
  resources :reviews, except: [:show, :index]
  resources :teas 

  resources :brands do # nested route
    resources :teas, only: [:index, :new, :create]
  end

  resources :teas do # or brands? tea makes more sense 
    resources :reviews, only: [:index, :new, :create]
  end
end