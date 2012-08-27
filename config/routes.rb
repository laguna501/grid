GRID::Application.routes.draw do

  resources  :grids, only: [:index] do
    collection do
      get :show_users
      get :get_access_token
      get :show_by_user
      get :show_photo
    end
  end

  root to: "grids#index"
end
