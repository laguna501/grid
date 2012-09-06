class GridsController < ActionController::Base
  layout 'application'

  def index; end

  def show_users
    @type = params[:type]
    users = User.where(user_type: @type).where("access_token IS NOT NULL")
    fb_users = Hash.new
    users.each do |user|
      fb_users[user.facebook_uid] = FbGraph::User.fetch(user.facebook_uid, :access_token => user.access_token)
    end

    app = FbGraph::Application.new(135259466618586, :secret => '5c7369efc1f535f76e7640779cfd97e4')

    @user_photos = Hash.new
    fb_users.each do |nickname, user|
      @user_photos[nickname] = []
      user.albums.each do |album|
        album.photos.each do |photo|
          next unless photo.name =~ /#grid/           #fixed description must have #grid word
          @user_photos[nickname] << photo
        end
      end
    end
  end

  def show_photo
    @photo_identifier = params['identifier']
    @owner = params['owner']

    user = User.where(facebook_uid: @owner)
    photo = FbGraph::Photo.fetch(@photo_identifier, :access_token => user.access_token)

    @photo_description = photo.name
    photo.images.each do |image|
      next unless image.width <= 780 && 600 < image.width
      @user_photo = image and break
    end
  end
end
