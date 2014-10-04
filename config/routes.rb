Rails.application.routes.draw do

  root to: 'topics#index'

  resources :topics do
  	resources :subtopics
  end	
  resources :subtopics do
  	resources :comments
  end
  
  resources :comments	

  resources :sessions
  

end
