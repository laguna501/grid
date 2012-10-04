class GridsController < ApplicationController
  layout 'application'

  def index; end

  def show_users
    @type = params[:type]
    @users = User.includes(accounts: :photos).where(user_type: @type).where("photos.id IS NOT NULL").map(&:nickname)
    @page = 0
  end

  def infinite_scroll
    type = params[:type]
    @page = params[:page]
    limit_per_page = 50;
    
    @photos = Photo.includes(account: :user).where("users.user_type = ?", type
      ).where("access_token IS NOT NULL").where(
        "photos.deleted = ?", false
      ).offset(@page.to_i * limit_per_page).limit(limit_per_page).order("photos.id DESC")

    @page = @page.to_i + 1
    render layout: false
  end

  def show_photo
    @photo_identifier = params['identifier']
    @owner = params['owner']
    account = Account.includes(:user).where("users.nickname = ?", @owner).first
    photo = Photo.where(identifier: @photo_identifier, account_id: account).first

    @photo_description = photo.description
    @user_photo = photo.full
  end
end
