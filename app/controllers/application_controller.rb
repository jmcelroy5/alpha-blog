class ApplicationController < ActionController::Base
  # makes the methods available in the views as well as the controllers
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    session[:user_id].present?
  end

  def require_user
    if !logged_in?
      flash[:alert] = "You must be logged in to access that"
      redirect_to login_path
    end
  end
end
