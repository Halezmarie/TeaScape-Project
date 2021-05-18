class SessionsController < ApplicationController

    def new #new renders the login form for users
      if logged_in?
        redirect_to root_path
      end 
    end
  
    def create #going through the login form
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password]) #if user is found and gives correct password
        session[:user_id] = user.id #userid for session
        redirect_to root_path #rendering root path aka application/welcome!
      else 
        render :new #go back to login form if the info isnt correct 
      end 
    end
  
    def destroy  #delete 
      session.delete :user_id #logout user
      redirect_to login_path
    end
  
    
  end