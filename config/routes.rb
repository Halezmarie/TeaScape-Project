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

  resources :users
  resources :reviews 
  resources :teas 

  resources :brands do
    resources :teas, only: [:index, :new, :create]
  end

  resources :teas do 
    resources :reviews, only: [:index, :new, :create]
  end
end

