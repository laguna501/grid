class GridsController < ActionController::Base
  layout 'application'
  # before_filter :facebook_fetch, only: [:pro, :girl]

  def index; end

  def show_users
    @type = params[:type]
    users = User.joins(:album).where(type: @type)

    app = FbGraph::Application.new(135259466618586, :secret => '5c7369efc1f535f76e7640779cfd97e4')
    users = {
      "artiwarah" => FbGraph::User.fetch('artiwarah', :access_token => 'AAACEdEose0cBAAcoR1ZAjcfiz9TT4PdEAIjBIRD8aEih9AtfoIIS6O0CMa8T6tdTuvZAsp6WIYEhK4jZAIb3zgEQoMmCk9QziAueZAsEZCOOseOxei81r'),
      "chanisa.suwannarang" => FbGraph::User.fetch('chanisa.suwannarang', :access_token => 'AAACEdEose0cBAPL5x6Sagu6HPsOQnBY62z3hQcoSV1ZBJSJ6ykPfg6AgpgGCFfFiRUp4E0Ux6blBA05Xb4i3aUflFzX5bhAwJdg6f7nmOqpNBSj1M'),
      "eadheat" => FbGraph::User.fetch('eadheat', :access_token => 'AAACEdEose0cBADlYjdlz2DFMZBJ4U0upprQNsbFD57Yds2ZCVXe94Xe7x7xP0QZAEVOpUf5ma8TcS93l7J8eLHI3vHoZBc0HVyR8wKZC7HUFjh8WsXt4N')
    }

    @user_photos = Hash.new
    users.each do |nickname, user|
      @user_photos[nickname] = []
      user.albums.each do |album|
        next unless album.name =~ /Cover Photos/                            #fixed album name
        album.photos.each do |photo|
          next unless photo.name =~ /#grid/                                 #fixed description must have #grid word
          @user_photos[nickname] << photo
        end
      end
    end
  end

  def show_photo
    @photo_identifier = params['identifier']
    @owner = params['owner']

    access_tokens = {
      'artiwarah' => 'AAACEdEose0cBAAcoR1ZAjcfiz9TT4PdEAIjBIRD8aEih9AtfoIIS6O0CMa8T6tdTuvZAsp6WIYEhK4jZAIb3zgEQoMmCk9QziAueZAsEZCOOseOxei81r',
      'chanisa.suwannarang' => 'AAACEdEose0cBAPL5x6Sagu6HPsOQnBY62z3hQcoSV1ZBJSJ6ykPfg6AgpgGCFfFiRUp4E0Ux6blBA05Xb4i3aUflFzX5bhAwJdg6f7nmOqpNBSj1M',
      'eadheat' => 'AAACEdEose0cBADlYjdlz2DFMZBJ4U0upprQNsbFD57Yds2ZCVXe94Xe7x7xP0QZAEVOpUf5ma8TcS93l7J8eLHI3vHoZBc0HVyR8wKZC7HUFjh8WsXt4N'
    }

    photo = FbGraph::Photo.fetch(@photo_identifier, :access_token => access_tokens[@owner])
    @photo_description = photo.name
    photo.images.each do |image|
      next unless image.width <= 780 && 700 < image.width
      @user_photo = image and break
    end
  end

  def get_access_token
    client.authorization_code = params[:code]
    access_token = client.access_token! :client_auth_body # => Rack::OAuth2::AccessToken
    @pro = FbGraph::User.me(access_token).fetch # => FbGraph::User
  end

  def facebook_fetch
    @fb_auth = FbGraph::Auth.new(135259466618586, '5c7369efc1f535f76e7640779cfd97e4')
    client = fb_auth.client
    client.redirect_uri = "http://your.client.com/facebook/callback"

    redirect_to client.authorization_uri(
      :scope => [:email, :read_stream, :offline_access]
    )
  end

  def callback
    client.authorization_code = params[:code]
    access_token = client.access_token! :client_auth_body # => Rack::OAuth2::AccessToken
    FbGraph::User.me(access_token).fetch # => FbGraph::User
  end
end
