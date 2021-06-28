class ApplicationController < ActionController::Base
include ApplicationHelper

#   helper_method :current_user, :logged_in?
helper_method :current_user, :logged_in?

private 

  
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