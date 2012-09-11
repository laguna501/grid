class ManageController < ActionController::Base
  layout 'application'
  CALLBACK_URL = "https://grid.swiftlet.co.th/manage/callback_instagram"

  def index; end

  def get_access_token; end

  def extend_access_token
    @client = client

    redirect_to @client.authorization_uri(
      :scope => [:email, :user_photos]
    )
  end

  def callback
    @client = client
    @client.authorization_code = params[:code]
    access_token = @client.access_token! :client_auth_body # => Rack::OAuth2::AccessToken
    fb_user = FbGraph::User.me(access_token).fetch # => FbGraph::User

    user = User.where(username: fb_user.username).first
    unless user.blank?
  		user.access_token = fb_user.access_token.access_token
  		user.save
    end
    redirect_to grids_url
  end

  def callback_instagram    
    response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)    
    @access_token_instagram = response.access_token

    client = Instagram.client(:access_token => @access_token_instagram)
    ig_user = client.user

    user = User.where(username: ig_user.username, social_type: "instagram").first
    user.access_token = @access_token_instagram
    user.save

    redirect_to grids_url
  end

  def pull_photos
    users = User.where("access_token IS NOT NULL").where(social_type: "facebook")
    @fb_users = Hash.new
    users.each do |user|
      @fb_users[user.username] = FbGraph::User.fetch(user.username, :access_token => user.access_token)
    end

    all_photo = Photo.all.map(&:identifier)
    
    @user_photos = Hash.new
    @fb_users.each do |username, user|
      @user_photos[username] = []
      album = user.albums.detect do |album|
        album.name =~ /Cover Photo/
      end
      album.photos.each do |photo|
        next unless photo.name =~ /#grid/           #fixed description must have #grid word
        next if all_photo.include?(photo.identifier)
        @user_photos[username] << photo
      end
    end

    @user_photos.each do |username, photos|
      photos.each do |photo| 
        user_photo = Photo.new
        user_photo.identifier = photo.identifier
        user_photo.description = photo.name
        user_photo.user = User.where(username: username).first
        photo.images.each do |image| 
          user_photo.photo_type = image.height > image.width ? "portrait" : "landscape" 
          next unless image.width <= 780 && 600 < image.width
          user_photo.full = image.source
          break
        end 

        photo.images.each do |image| 
          next if image.height < image.width && image.height > 200 
          next if image.height > image.width && image.width > 200
          user_photo.thumbnail = image.source
          break
        end

        user_photo.full = user_photo.save_file(username, user_photo.full)
        user_photo.thumbnail = user_photo.save_file(username, user_photo.thumbnail)
        user_photo.save
      end 
    end 

    redirect_to grids_url
  end

  private
  def client
    fb_auth = FbGraph::Auth.new('135259466618586', '5c7369efc1f535f76e7640779cfd97e4')
    client = fb_auth.client
    client.redirect_uri = "http://grid.swiftlet.co.th/manage/callback"
    client
  end

end
