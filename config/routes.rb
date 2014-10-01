Rails.application.routes.draw do

  root to: 'home#index'
  resources :home

  resources :topics do
  	resources :comments
  	resources :home
  end	

  resources :sessions

end
