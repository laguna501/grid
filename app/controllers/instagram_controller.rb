class InstagramController < ActionController::Base
  require "instagram"
  before_filter :connect, only: :index

  CALLBACK_URL = "https://grid.swiftlet.co.th/instagram/callback"

  def index; end

  def connect
    Instagram.configure do |config|
      config.client_id = "cf32424d71d4445995bf58ec0e2a3bd2"
      config.client_secret = "5e0be7f1d1b74102acb324183cdf6c3f"
    end

    redirect_to Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
  end

  def callback  
    response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)    
    @access_token_instagram = response.access_token

    client = Instagram.client(:access_token => @access_token_instagram)
    ig_user = client.user

    account = Account.where(username: ig_user.username, social_type: "instagram").first
    account.access_token = @access_token_instagram
    account.save

    redirect_to grids_url
  end
end
