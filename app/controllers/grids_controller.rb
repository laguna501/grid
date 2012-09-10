class GridsController < ActionController::Base
  layout 'application'

  def index; end

  def show_users
    @type = params[:type]
    users = User.includes(:photos).where(user_type: @type).where("access_token IS NOT NULL")
    @user_photos = Hash.new
    users.each do |user|
      @user_photos[user.username] = user.photos
    end
  end

  def show_photo
    @photo_identifier = params['identifier']
    @owner = params['owner']
    user = User.where(username: @owner).first
    photo = FbGraph::Photo.fetch(@photo_identifier, :access_token => user.access_token)

    @photo_description = photo.name
    photo.images.each do |image|
      next unless image.width <= 780 && 600 < image.width
      @user_photo = image and break
    end
  end
end
