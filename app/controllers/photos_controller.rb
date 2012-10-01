class PhotosController < ApplicationController
  before_filter :redirect_other_roles
  before_filter :require_user
  layout 'application'

  def index
    @photos = Photo.includes(account: :user).paginate(:page => params[:page], :per_page => 50)
  end

  def change_status
    command = params[:commit] == "Delete Photos" ? true : false
  	if params[:select].present?
  		photos = Photo.find(:all, :conditions => ["identifier IN (?)", params[:select] ] )
  		photos.each do |photo|
  			photo.deleted = command
  			photo.save
  		end
  		flash[:notice] = "Update photos successfully."
  	end
  	redirect_to photos_url
  end

  def redirect_other_roles
    if (current_user.blank?)
        redirect_to(new_user_session_url)
    end    
  end
  
  def change_highlight
    identifier = params[:identifier]
    highlighted = params[:highlight]
    photo = Photo.where(identifier: identifier).first
    photo.highlighted = highlighted
    photo.save
    render :nothing => true
  end
end