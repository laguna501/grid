class GridsController < ActionController::Base
  layout 'application'
  before_filter :facebook_fetch, only: [:index]

  def index; end

  def show_users
    @type = params[:type]
    users = User.includes(:album).where(type: @type)
    fb_users = Hash.new
    users.each do |user|
      fb_users[fb_users.uid] << FbGraph::User.fetch(fb_users.uid, :access_token => fb_users.access_token)
    end
    # fb_users = {
    #   "artiwarah" => FbGraph::User.fetch('artiwarah', :access_token => 'AAACEdEose0cBACZCOdkzmDI6NKO4qI3GgTPVpJpapF39A5GVqxo7lf6C9HMZAvGfl1E1zWr4OeHgTKtFLj8eAM3zZBrEE2bZAfqJcYB0tXee28q7PYYJ'),
    #   "chanisa.suwannarang" => FbGraph::User.fetch('chanisa.suwannarang', :access_token => 'AAACEdEose0cBALkX2Mv6POymslNw0BjBEbj83vaaViVmvPnPs7xrWhcDrTfMo74tMnarocZAwxYR5MSTmyZBfIjIrNnXDjTKZAf7hdYO2k7ZBziZAQIL4'),
    #   "eadheat" => FbGraph::User.fetch('eadheat', :access_token => 'AAACEdEose0cBAEugnK8l278ZB90FWsUbrdT7fpcpCwZBCy8DXgRRg6it9zZBMWb5uhBTgKzaKk23MlP5TyhNl4s9XzC4TQNRERqZAw77BE2wVH4cPfPE')
    # }

    app = FbGraph::Application.new(135259466618586, :secret => '5c7369efc1f535f76e7640779cfd97e4')

    @user_photos = Hash.new
    fb_users.each do |nickname, user|
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

    user = User.where(uid: @owner)
    photo = FbGraph::Photo.fetch(@photo_identifier, :access_token => user.access_token)

    # access_tokens = {
    #   'artiwarah' => 'AAACEdEose0cBAKn1hCJfyz0f0hEwmUdkWJ2T4MZABdq91o7gcAsF5VN0yztxsRQ3FP5b7zWLIH0sZAdopm7wWrXYYqh19y2W38OnDvIF2ZA5PM51RhN',
    #   'chanisa.suwannarang' => 'AAACEdEose0cBALkX2Mv6POymslNw0BjBEbj83vaaViVmvPnPs7xrWhcDrTfMo74tMnarocZAwxYR5MSTmyZBfIjIrNnXDjTKZAf7hdYO2k7ZBziZAQIL4',
    #   'eadheat' => 'AAACEdEose0cBAEugnK8l278ZB90FWsUbrdT7fpcpCwZBCy8DXgRRg6it9zZBMWb5uhBTgKzaKk23MlP5TyhNl4s9XzC4TQNRERqZAw77BE2wVH4cPfPE'
    # }

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
    fb_auth = FbGraph::Auth.new(135259466618586, '5c7369efc1f535f76e7640779cfd97e4')
    client = fb_auth.client
    client.redirect_uri = "http://grid.swiftlet.co.th/grids/callback"

    redirect_to client.authorization_uri(
      :scope => [:email, :read_stream, :offline_access, :user_photos]
    )
  end

  def callback
    client.authorization_code = params[:code]
    access_token = client.access_token! :client_auth_body # => Rack::OAuth2::AccessToken
    fb_user = FbGraph::User.me(access_token).fetch # => FbGraph::User

    users = User.where(facebook_uid: fb_user.uid)
    if users.count == 0
      user = User.new(facebook_uid: fb_user.uid, email: fb_user.email, access_token: access_token, type: "pro")
      user.save
    end
    render(action: "index")
  end
end
