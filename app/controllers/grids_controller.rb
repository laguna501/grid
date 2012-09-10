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
    photo = Photo.where(identifier: @photo_identifier, user_id: user).first

    @photo_description = photo.description
    @user_photo = photo.full
  end
end
