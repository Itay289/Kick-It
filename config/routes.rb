Rails.application.routes.draw do

  root to: 'home#index'
  
  resources :home

  resources :topics do
  	resources :comments
  end	

  resources :sessions

end
