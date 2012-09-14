GRID::Application.routes.draw do

  resources  :grids, only: [:index, :new, :create] do
    collection do
      get :show_users
      get :show_by_user
      get :show_photo
    end
  end
  
  resources :facebook, only: [:index] do
    collection do
      get :callback
      get :access_token_expired
      get :facebook_send_admin_email
    end
  end

  resources :instagram, only: [:index] do
    collection do
      get :callback
    end
  end

  root to: "grids#index"
end
