class SessionsController < ApplicationController

    def new # new renders the login form for users
      if logged_in?
        redirect_to root_path
      end 
    end
  
    def create # going through the login form
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password]) # if user is found and gives correct password
        session[:user_id] = user.id # userid for session
        redirect_to root_path # rendering root path aka application/welcome!
      else 
        render :new # go back to login form if the info isnt correct 
      end 
    end
  
    def destroy  # delete 
      session.delete :user_id # logout user
      redirect_to login_path
    end
  
    def omniauth 
      user = User.find_or_create_by(uid: request.env['omniauth.auth'][:uid], provider: request.env['omniauth.auth'][:provider]) do |u|
        u.username = request.env['omniauth.auth'][:info][:first_name]
        u.email = request.env['omniauth.auth'][:info][:email]
        u.password = SecureRandom.hex(17) # if a number isnt specified it will automatically be 16
      end 
      if user.valid? # if the user passes the tests, then log them in 
        session[:user_id] = user.id 
        redirect_to root_path
      else
        redirect_to login_path 
      end 
    end 
  end