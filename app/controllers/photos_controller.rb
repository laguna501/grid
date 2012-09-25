class PhotosController < ActionController::Base
  layout 'application'

  def index
    @photos = Photo.includes(account: :user).paginate(:page => params[:page], :per_page => 50)
  end

  def create
  	redirect_to photos_url
  end
end