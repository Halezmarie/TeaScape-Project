class ApplicationController < ActionController::Base
    include ApplicationHelper

    def welcome 
        if !logged_in? #failure to login
            redirect_to login_path
        end 
    end 

end