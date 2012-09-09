class InstagramController < ActionController::Base
  require "instagram"

  CALLBACK_URL = "https://grid.swiftlet.co.th/manage/callback_instagram"

  def index    
    Instagram.configure do |config|
      config.client_id = "cf32424d71d4445995bf58ec0e2a3bd2"
      config.client_secret = "5e0be7f1d1b74102acb324183cdf6c3f"
    end
    redirect_to manage_index_url
  end

  def connect
    redirect_to Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
  end
end
