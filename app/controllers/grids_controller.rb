class GridsController < ActionController::Base
  layout 'application'
  # before_filter :facebook_fetch, only: [:pro, :girl]

  def index; end

  def show_users
    users = User.joins(:album).where(type: params[:type])

    app = FbGraph::Application.new(135259466618586, :secret => '5c7369efc1f535f76e7640779cfd97e4')
    users = [
      FbGraph::User.fetch('artiwarah', :access_token => 'AAACEdEose0cBACWJwsjtW7UdSSw1R804w5dkxwcEa1XcSM0y2ZB29bPkgyjplNsZByVuxSM7wYieC41YyvUYoyYHSRAJRyd15AfrpAPyRtxFmrG1e2'),
      FbGraph::User.fetch('chanisa.suwannarang', :access_token => 'AAACEdEose0cBACZB5Hqkxar1qjqHoVik3qGDsSkVLkaSw5UZCVil87tZBv59crp0NMZBRxcdP1IIFJqnu2MfPrTMHhgaIz0lnzIliU1tcVryrXROnNWB'),
      FbGraph::User.fetch('eadheat', :access_token => 'AAACEdEose0cBAPw24ZA1ROfnTnESrZBg8qY2gVFJFZCntnCZArXKFlFZBBqjL0RhftDwbrZClvDqNHRClGLKeBiemnH6dGmiOaNKavfIhUqxP9uLDG44cv'),
      FbGraph::User.fetch('pinmanee.chaisawat', :access_token => 'AAACEdEose0cBAIjdPt6iGpYtrDPGyHE6NV3tpw5wc86ZCf93ZBAThZAQ8xBRUTxWbHdMaWs5ZBvTcoZAn2QQEqdqpZBbveGrUcVa5Bzuh3SV3jeJ7itmOS')
    ]

    @user_profile_pictures = Hash.new
    users.each do |user|
      user.albums.each do |album|
        next unless album.name =~ /Profile Pictures/
        @user_profile_pictures[user.username] = album.photos.first
      end
    end
  end

  def show_by_user
    access_tokens = {
      'artiwarah' => 'AAACEdEose0cBACWJwsjtW7UdSSw1R804w5dkxwcEa1XcSM0y2ZB29bPkgyjplNsZByVuxSM7wYieC41YyvUYoyYHSRAJRyd15AfrpAPyRtxFmrG1e2',
      'chanisa.suwannarang' => 'AAACEdEose0cBACZB5Hqkxar1qjqHoVik3qGDsSkVLkaSw5UZCVil87tZBv59crp0NMZBRxcdP1IIFJqnu2MfPrTMHhgaIz0lnzIliU1tcVryrXROnNWB',
      'eadheat' => 'AAACEdEose0cBAPw24ZA1ROfnTnESrZBg8qY2gVFJFZCntnCZArXKFlFZBBqjL0RhftDwbrZClvDqNHRClGLKeBiemnH6dGmiOaNKavfIhUqxP9uLDG44cv',
      'pinmanee.chaisawat' => 'AAACEdEose0cBAIjdPt6iGpYtrDPGyHE6NV3tpw5wc86ZCf93ZBAThZAQ8xBRUTxWbHdMaWs5ZBvTcoZAn2QQEqdqpZBbveGrUcVa5Bzuh3SV3jeJ7itmOS'
    }

    unless params[:user_identifier].blank?
      @user = FbGraph::User.fetch(params[:user_identifier], :access_token => access_tokens[params[:user_identifier]])
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
    client.redirect_uri = "http://your.client.com/facebook/callback"

    redirect_to client.authorization_uri(
      :scope => [:email, :read_stream, :offline_access]
    )
  end

  def callback
    client.authorization_code = params[:code]
    access_token = client.access_token! :client_auth_body # => Rack::OAuth2::AccessToken
    FbGraph::User.me(access_token).fetch # => FbGraph::User
  end
end
