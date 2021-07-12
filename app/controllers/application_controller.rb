class ApplicationController < ActionController::Base
include ApplicationHelper
# helper_method :current_user, :logged_in?
helper_method :current_user, :logged_in?

private 

  def require_login
    unless current_user
      redirect_to login_path
    end
  end

  # only say true and false for my boolean
  def logged_in?
    !!session[:user_id]
  end


  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

end

# get used to manipulating hashes / session hashes 