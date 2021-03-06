class GridsController < ApplicationController
  layout 'application'

  def index; end

  def show
    @user = User.where(nickname: params[:id]).first
    @type = @user.user_type
    @users = User.includes(accounts: :photos).where(user_type: @type).where("photos.id IS NOT NULL").map(&:nickname)
    @page = 0
    @title = @user.full_name
    render action: :show_users
  end

  def show_users
    @type = params[:type]
    @users = User.includes(accounts: :photos).where(user_type: @type).where("photos.id IS NOT NULL").map(&:nickname)
    @page = 0
    @title = "Photo from all #{@type.to_s.titleize}s"
  end

  def infinite_scroll
    type = params[:type]
    @page = params[:page]
    limit_per_page = 20;

    @photos = Photo.includes(account: :user).where("users.user_type = ?", type
      ).where("access_token IS NOT NULL").where(
        "photos.deleted = ?", false
      ).offset(@page.to_i * limit_per_page).limit(limit_per_page).order("photos.id DESC")
    @photos = @photos.where(users: {id: params[:user]}) if params[:user].present?
    @page = @page.to_i + 1
    render layout: false
  end

  def show_photo
    @photo_identifier = params['identifier']
    @owner = params['owner']
    account = Account.includes(:user).where("users.nickname = ?", @owner).all
    photo = Photo.where(identifier: @photo_identifier, account_id: account).first
    user = User.where(nickname: @owner).first

    @photo_description = photo.description
    @user_photo = photo.full
    @photo_created = photo.created_at
    @user_fullname = user.full_name

    @page_site         = 'Canon LifeSpace'
    @page_type         = 'article'
    @page_image        = photo.thumbnail
    @page_description  = photo.description
    @page_app_id       = '214995985312005' #also edit id in grids.js

  end
end
