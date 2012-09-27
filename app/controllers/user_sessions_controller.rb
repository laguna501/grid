class UserSessionsController < ApplicationController

  def new
    @user_session = UserSession.new
  end

  def create
    # @user_session = UserSession.new(params[:user_session])
    # if @user_session.save
    #   redirect_to account_url
    # else
    #   render :action => :new
    # end

    unless @user_session = UserSession.new(params[:user_session]) and @user_session.valid?
      flash[:error] = "Login fail"
      redirect_to(new_user_session_path)
      return
    end
    destroy_session

    @user_session = UserSession.create(params[:user_session])
    flash[:error] = "seccessfuly"
    redirect_back_or_default photos_path
  end

  def destroy
    current_user_session.destroy
    redirect_to new_user_session_path
  end
end