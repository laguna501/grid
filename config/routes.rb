GRID::Application.routes.draw do

  resources  :grids, only: [:index, :new, :create] do
    collection do
      get :show_users
      get :show_by_user
      get :show_photo
    end
  end
  
  resources :manage, only: [:index] do
    collection do
      get :callback
      get :extend_access_token
      get :get_access_token_facebook
      get :get_access_token_instagram
      get :pull_photos
      get :pull_photos_instagram
    end
  end

  resources :instagram, only: [:index] do
    collection do
      get :connect
      get :callback_instagram
    end
  end

  root to: "grids#index"
end
