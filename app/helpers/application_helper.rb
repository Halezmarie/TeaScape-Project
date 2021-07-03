module ApplicationHelper
#helpers
# saving a method's return value so it does not have to be recomputed each time
def render_nav_bar
    if logged_in?
      render partial: 'layouts/loggedin_links'
    else
        redirect_to root_path
    end
  end

    def current_user  
        @current_user ||= User.find_by(id: session[:user_id])
    end 

    def logged_in?
        current_user
    end 
end

