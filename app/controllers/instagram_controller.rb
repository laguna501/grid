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

  def access_token_expired
    # instagram_accounts = Account.where(social_type: "instagram")
    # instagram_accounts.each do |instagram_account|
    #   token_life_time = (instagram_account.updated_at + 60.days) - Time.now
    #   next unless (token_life_time  <= 3.days)
    #   user = User.find(facebook_account.user_id)
    #   user.deliver_extend_facebook_access_token
    # end    
    head(:ok)
  end
end
