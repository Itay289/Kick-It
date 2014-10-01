Rails.application.routes.draw do

  root to: 'home#index'

  resources :topics

  resources :sessions

end
