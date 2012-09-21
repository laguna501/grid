class InstagramController < ActionController::Base
  require "instagram"
  before_filter :connect, only: :index

  CALLBACK_URL = Rails.configuration.ig_callback_url

  def index; end

  def connect
    Instagram.configure do |config|
      config.client_id = Rails.configuration.ig_client_id
      config.client_secret = Rails.configuration.ig_client_secret
    end

    redirect_to Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
  end

  def callback  
    response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)    
    @access_token_instagram = response.access_token

    client = Instagram.client(:access_token => @access_token_instagram)
    ig_user = client.user

    account = InstagramAccount.where(username: ig_user.username).first
    account.access_token = @access_token_instagram
    account.save

    redirect_to grids_path
  end
end
