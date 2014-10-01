Rails.application.routes.draw do

  root to: 'topics#index'


  resources :topics do
  	resources :subtopics
  end	

  resources :sessions

end
