class ApplicationController < ActionController::Base
include ApplicationHelper
before_action :require_login
#   helper_method :current_user, :logged_in?
helper_method :current_user, :logged_in?

private 

  def require_login
    unless current_user
      redirect_to login_path
    end
  end
  
  def welcome 
    if !logged_in? # failure to login
        redirect_to login_path
    end 
  end 

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

end