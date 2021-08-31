class ApplicationController < ActionController::Base
include ApplicationHelper 
# helper_method :current_user, :logged_in?


private 
  
  def require_login 
    unless current_user
      redirect_to login_path
    end
  end

end