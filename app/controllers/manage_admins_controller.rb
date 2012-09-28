class ManageAdminsController < ApplicationController
  before_filter :redirect_other_roles
  before_filter :require_user
  layout 'application'

  def index
    @admins = Admin.all
  end

  def new    
    @admin = Admin.new
  end

  def create    
    @admin = Admin.new(params[:admin])

    if @admin.save
      flash[:notice] = "Admin successfully created."
      redirect_to manage_admins_url
    else
      flash.now[:error] = []
      flash[:error] ||= ["Cannot create admin."]
      flash[:error] << "#{@admin.errors.full_messages.join(", ")}"
      render :action => :new
    end
  end

  def edit
    @admin = Admin.find(params[:id])    
  end

  def update
    @admin = Admin.find(params[:id])
    @admin.original_password = params[:admin][:original_password]
    @admin.username = params[:admin][:username]
    @admin.password = params[:admin][:password]
    @admin.password_confirmation = params[:admin][:password_confirmation]
    @admin.override_rules = true if current_user != @admin
    if @admin.save
      flash[:notice] = "Admin successfully updated."
      redirect_to(manage_admins_url)
    else
      flash.now[:error] = []
      flash[:error] ||= ["Cannot update admin."]
      flash[:error] << "#{@admin.errors.full_messages.join(", ")}"
      render action: :edit
    end
  end

  def destroy
    @admin = Admin.find(params[:id])

    @admin.destroy
    redirect_to(manage_admins_url)
    flash[:notice] = "Admin successfully destroyed."
  end

  def redirect_other_roles
    if (current_user.blank?)
        redirect_to(new_user_session_url)
    end    
  end
end