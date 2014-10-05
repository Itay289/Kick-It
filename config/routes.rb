Rails.application.routes.draw do

  root to: 'topics#index'

  resources :topics do
  	resources :subtopics do
      resources :comments
    end
  end	
  
  resources :sessions
  
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/signin', to: 'sessions#new', via: :get

end
