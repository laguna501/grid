class FacebookController < ActionController::Base
  layout 'application'
  before_filter :facebook_account, only: [:access_token_expired, :facebook_send_admin_email]

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

  def facebook_account
    @facebook_accounts = Account.includes(:user).where(social_type: "facebook")
  end

  def access_token_expired    
    @facebook_accounts.each do |facebook_account|
      @token_life_time = (facebook_account.updated_at + 60.days) - Time.now
      next unless @token_life_time  < 4.days
      facebook_account.deliver_extend_facebook_access_token
    end    
    head(:ok)
  end

  def facebook_send_admin_email
    @facebook_accounts.each do |facebook_account|
      @token_life_time = (facebook_account.updated_at + 60.days) - Time.now
      next unless @token_life_time  < 1.days
      facebook_account.deliver_facebook_report_to_admin
    end    
    head(:ok)
  end

  private
  def client
    fb_auth = FbGraph::Auth.new('135259466618586', '5c7369efc1f535f76e7640779cfd97e4')
    client = fb_auth.client
    client.redirect_uri = "http://grid.swiftlet.co.th/facebook/callback"
    client
  end  
end
