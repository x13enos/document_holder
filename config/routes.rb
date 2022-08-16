Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/login',    to: 'sessions#create'
      delete '/logout',   to: 'sessions#destroy'
      get '/logged_in', to: 'sessions#is_logged_in'


      resources :users, only: [:create, :update] do
        get :current_user_info, on: :collection
        put :update_profile, on: :collection
      end
      resources :documents, except: [:show, :new, :edit]
      resources :boxes, only: [:index, :create, :update, :destroy]
    end
  end

end
