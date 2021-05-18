module ApplicationHelper
#helpers
# saving a method's return value so it does not have to be recomputed each time
    def current_user  
        @current_user ||= User.find_by(id: session[:user_id])
    end 

    def logged_in?
        current_user
    end 
end

