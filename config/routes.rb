Rails.application.routes.draw do

  root to: 'topics#index'

  resources :topics do
  	resources :subtopics do
      resources :comments
    end
  end	

  resources :sessions
  

end
