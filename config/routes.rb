Rails.application.routes.draw do
  resources :users
  post '/auth/login', to: 'authentication#login'
  
  resources :games, except: [:new, :edit, :destroy]
end
