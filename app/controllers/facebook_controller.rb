class FacebookController < ApplicationController
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

    account = FacebookAccount.where(username: fb_user.username).first
    unless account.blank?
  		account.access_token = fb_user.access_token.access_token
  		account.save
    end
    redirect_to grids_path
  end

  private
  def client
    fb_auth = FbGraph::Auth.new(Rails.configuration.fb_app_id, Rails.configuration.fb_app_secret)
    client = fb_auth.client
    client.redirect_uri = Rails.configuration.fb_callback_url
    client
  end  
end
