class ManageController < ActionController::Base
  layout 'application'

  def index; end

  def facebook_fetch
    @client = client

    redirect_to @client.authorization_uri(
      :scope => [:email, :user_photos, :read_stream]
    )
  end

  def callback
    @client = client
    @client.authorization_code = params[:code]
    access_token = @client.access_token! :client_auth_body # => Rack::OAuth2::AccessToken
    fb_user = FbGraph::User.me(access_token).fetch # => FbGraph::User

    user = User.where(facebook_uid: fb_user.username).first
    if user.blank?
     	user = User.new(facebook_uid: fb_user.username, email: fb_user.email, access_token: fb_user.access_token.access_token, user_type: "pro")
     	user.save
  	else
		user.access_token = fb_user.access_token.access_token
		user.save
    end
    redirect_to grids_url
  end

  def client
    fb_auth = FbGraph::Auth.new('135259466618586', '5c7369efc1f535f76e7640779cfd97e4')
    client = fb_auth.client
    client.redirect_uri = "http://grid.swiftlet.co.th/manage/callback"
    client
  end
end
