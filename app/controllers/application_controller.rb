class ApplicationController < ActionController::Base
include ApplicationHelper 
helper_method :current_user, :logged_in?




private # private methods They are designed as internal helper methods and there is no way to expose them to web server.
  
  def require_login # require the login unless the current user is logged in
    unless current_user
      redirect_to login_path
    end
  end

  # only say true and false for my boolean -  checking if the user is logged in and the session matches the user_id 
  def logged_in? 
    !!session[:user_id]
  end
# !! is true and ! is false

  def current_user 
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  # This is saying that if @current_user value is null, then set that equal to user_id. Otherwise, keep the @current_user value.
  #  a ||= b is a conditional assignment operator. It means if a is undefined or falsey, then evaluate b and set a to the result. 
  # so if instance of current user is nill then find the user by the user id session if the session is equal to the user id 
end

# get used to manipulating hashes / session hashes 