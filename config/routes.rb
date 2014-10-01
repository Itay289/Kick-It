Rails.application.routes.draw do

  root to: 'topics#index'

  resources :subtopics

  resources :topics do
  	
  end	

  resources :sessions

end
