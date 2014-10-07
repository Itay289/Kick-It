Rails.application.routes.draw do

  root to: 'topics#index'

  resources :topics do
  	resources :sub_topics do
      member do
        put :upvote
      end

      # collection do
      #   get :search
      # end

    	resources :comments
    end
  end

  resources :comments
  
  resources :sessions do

  end

  
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/signin', to: 'sessions#new', via: :get

end
