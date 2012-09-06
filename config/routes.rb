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
      get :pull_photos
    end
  end

  root to: "grids#index"
end
