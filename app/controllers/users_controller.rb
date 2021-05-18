class UsersController < ApplicationController

def new #render the user signup form 
    if !logged_in? 
        @user = User.new 
    else 
        redirect_to root_path
    end 
end 

def create ##going through the signup form
    user = User.new(user_params)
    if user.save 
        session[:user_id] = user.id #user logs in
        redirect_to root_path #applicationwelcome
    else
        flash[:error] = "Oh no! Please try again!" #make validations for error 
        render :new #render signup form again 
    end 
end 

private

def user_params 
    params.require(:user).permit(:username, :email, :password)
end
end
