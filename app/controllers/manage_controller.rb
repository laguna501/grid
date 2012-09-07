class ManageController < ActionController::Base
  layout 'application'

  def index; end

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

    user = User.where(facebook_uid: fb_user.username).first
    if user.blank?
     	user = User.new
      user.facebook_uid = fb_user.username
      user.email = fb_user.email
      user.access_token = fb_user.access_token.access_token
      user.user_type = "pro"
     	user.save
  	else
  		user.access_token = fb_user.access_token.access_token
  		user.save
    end
    redirect_to grids_url
  end

  def pull_photos
    users = User.where("access_token IS NOT NULL")
    @fb_users = Hash.new
    users.each do |user|
      @fb_users[user.facebook_uid] = FbGraph::User.fetch(user.facebook_uid, :access_token => user.access_token)
    end

    Photo.destroy_all
    
    @user_photos = Hash.new
    @fb_users.each do |facebook_uid, user|
      @user_photos[facebook_uid] = []
      album = user.albums.detect do |album|
        album.name =~ /Cover Photo/
      end
      album.photos.each do |photo|
        next unless photo.name =~ /#grid/           #fixed description must have #grid word
        @user_photos[facebook_uid] << photo
      end
    end

    @user_photos.each do |facebook_uid, photos|
      photos.each do |photo| 
        user_photo = Photo.new
        user_photo.identifier = photo.identifier
        user_photo.description = photo.name
        user_photo.user = User.where(facebook_uid: facebook_uid).first
        photo.images.each do |image| 
          user_photo.photo_type = image.height > image.width ? "portrait" : "landscape" 

          # require 'uri'
          # require 'net/http'

          # full_url = URI.parse(image.source)
          # file_name = full_url.path.split("/").last

          # Net::HTTP.start( full_url.host ) { |http|
          #   resp = http.get( full_url.path )
          #   open( '/photos/'+file_name, 'wb' ) { |file|
          #     file.write(resp.body)
          #   }
          # }

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
