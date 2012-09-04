class GridsController < ActionController::Base
  layout 'application'
  before_filter :facebook_fetch, only: [:index]

  def index; end

  def show_users
    @type = params[:type]
    users = User.joins(:album).where(type: @type)

    app = FbGraph::Application.new(135259466618586, :secret => '5c7369efc1f535f76e7640779cfd97e4')
    users = {
      "artiwarah" => FbGraph::User.fetch('artiwarah', :access_token => 'AAACEdEose0cBAKn1hCJfyz0f0hEwmUdkWJ2T4MZABdq91o7gcAsF5VN0yztxsRQ3FP5b7zWLIH0sZAdopm7wWrXYYqh19y2W38OnDvIF2ZA5PM51RhN'),
      "chanisa.suwannarang" => FbGraph::User.fetch('chanisa.suwannarang', :access_token => 'AAACEdEose0cBALkX2Mv6POymslNw0BjBEbj83vaaViVmvPnPs7xrWhcDrTfMo74tMnarocZAwxYR5MSTmyZBfIjIrNnXDjTKZAf7hdYO2k7ZBziZAQIL4'),
      "eadheat" => FbGraph::User.fetch('eadheat', :access_token => 'AAACEdEose0cBAEugnK8l278ZB90FWsUbrdT7fpcpCwZBCy8DXgRRg6it9zZBMWb5uhBTgKzaKk23MlP5TyhNl4s9XzC4TQNRERqZAw77BE2wVH4cPfPE')
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
      'artiwarah' => 'AAACEdEose0cBAKn1hCJfyz0f0hEwmUdkWJ2T4MZABdq91o7gcAsF5VN0yztxsRQ3FP5b7zWLIH0sZAdopm7wWrXYYqh19y2W38OnDvIF2ZA5PM51RhN',
      'chanisa.suwannarang' => 'AAACEdEose0cBALkX2Mv6POymslNw0BjBEbj83vaaViVmvPnPs7xrWhcDrTfMo74tMnarocZAwxYR5MSTmyZBfIjIrNnXDjTKZAf7hdYO2k7ZBziZAQIL4',
      'eadheat' => 'AAACEdEose0cBAEugnK8l278ZB90FWsUbrdT7fpcpCwZBCy8DXgRRg6it9zZBMWb5uhBTgKzaKk23MlP5TyhNl4s9XzC4TQNRERqZAw77BE2wVH4cPfPE'
    }

    photo = FbGraph::Photo.fetch(@photo_identifier, :access_token => access_tokens[@owner])
    @photo_description = photo.name
    photo.images.each do |image|
      next unless image.width <= 780 && 600 < image.width
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
    client.redirect_uri = "grid.swiftlet.co.th/callback"

    redirect_to client.authorization_uri(
      :scope => [:email, :read_stream, :offline_access, :albums, :photos]
    )
  end

  def callback
    client.authorization_code = params[:code]
    access_token = client.access_token! :client_auth_body # => Rack::OAuth2::AccessToken
    FbGraph::User.me(access_token).fetch # => FbGraph::User
  end
end
