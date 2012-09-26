class PhotosController < ActionController::Base
  before_filter :redirect_other_roles
  authorize_resource class: false  
  layout 'application'

  def index
    @photos = Photo.includes(account: :user).paginate(:page => params[:page], :per_page => 50)
  end

  def change_status
  	if params[:select].present?
  		photos = Photo.find(:all, :conditions => ["identifier IN (?)", params[:select] ] )
  		photos.each do |photo|
  			photo.deleted = !photo.deleted
  			photo.save
  		end
  		flash[:notice] = "Update photos successfully."
  	end
  	redirect_to photos_url
  end

  def redirect_other_roles
    if (params[:id].blank?)
        redirect_to(new_user_session_url)
    end    
  end
end