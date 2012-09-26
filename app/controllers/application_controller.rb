class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user_session, :current_user

  private
	  def destroy_session
	    return_to = session[:return_to]
	    current_user_session && current_user_session.destroy
	    reset_session
	    session[:return_to] = return_to if return_to.present?
	  end

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    def redirect_back_or_default(default)
	    redirect_to(session[:return_to] || default)
	    session[:return_to] = nil
	  end
end
