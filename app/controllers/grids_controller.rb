class GridsController < ActionController::Base
  layout 'application'
  # before_filter :facebook_fetch, only: [:pro, :girl]

  def index; end

  def show_users
    users = User.joins(:album).where(type: params[:type])

    app = FbGraph::Application.new(135259466618586, :secret => '5c7369efc1f535f76e7640779cfd97e4')
    users = [
      FbGraph::User.fetch('artiwarah', :access_token => 'AAACEdEose0cBAFFGRRsK4zrZAqV11wocYe6uLiSGK3otS2SA71MksGh3pHcI1HN7KwUSSAXBGWeVkicvRxHZCU81OVgor89rrTmXza2lIt1I1RPSNG'),
      FbGraph::User.fetch('chanisa.suwannarang', :access_token => 'AAACEdEose0cBAFJJtVDMaCvqcZCGUQCB4TXibPDjtr3dbJjmVkf9kly5PEqPlmxpQmB8zPDwXhyEGbts5gFSWeLgRzZATDFXeyEWIThWlVfCDFVZC70'),
      FbGraph::User.fetch('eadheat', :access_token => 'AAACEdEose0cBAJL8OVZALgVO8P1Ptih7HGnMJYUZA3YQKpFZBWVv6uefn2rzuaKTZBZCn1b8sYURU6PFy13v9W48PKeArfVXwaB4CpuJ8OUizdfHKv3I9')
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
      'artiwarah' => 'AAACEdEose0cBAFFGRRsK4zrZAqV11wocYe6uLiSGK3otS2SA71MksGh3pHcI1HN7KwUSSAXBGWeVkicvRxHZCU81OVgor89rrTmXza2lIt1I1RPSNG',
      'chanisa.suwannarang' => 'AAACEdEose0cBAFJJtVDMaCvqcZCGUQCB4TXibPDjtr3dbJjmVkf9kly5PEqPlmxpQmB8zPDwXhyEGbts5gFSWeLgRzZATDFXeyEWIThWlVfCDFVZC70',
      'eadheat' => 'AAACEdEose0cBAJL8OVZALgVO8P1Ptih7HGnMJYUZA3YQKpFZBWVv6uefn2rzuaKTZBZCn1b8sYURU6PFy13v9W48PKeArfVXwaB4CpuJ8OUizdfHKv3I9'
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
