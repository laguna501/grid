class GridsController < ApplicationController
  layout 'application'

  def index; end

  def show_users
    @type = params[:type]
    accounts = Account.includes(:user).includes(:photos).where("users.user_type = ?", @type).where("access_token IS NOT NULL").where("photos.deleted = ?", false)
    @user_photos = Hash.new
    accounts.each do |account|
      @user_photos[account.user.nickname] = account.photos
    end
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
