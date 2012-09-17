class FacebookController < ActionController::Base
  layout 'application'

  def index
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

    account = Account.where(username: fb_user.username, social_type: "facebook").first
    unless account.blank?
  		account.access_token = fb_user.access_token.access_token
  		account.save
    end
    redirect_to grids_url
  end

  private
  def client
    fb_auth = FbGraph::Auth.new('135259466618586', '5c7369efc1f535f76e7640779cfd97e4')
    client = fb_auth.client
    client.redirect_uri = "http://grid.swiftlet.co.th/facebook/callback1"
    client
  end  
end
