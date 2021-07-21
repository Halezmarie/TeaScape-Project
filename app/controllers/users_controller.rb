class UsersController < ApplicationController

  def new # render the user signup form 
    if !logged_in? 
        @user = User.new 
    else 
        redirect_to root_path
    end 
  end 

  def create # going through the signup form
     @user = User.new(user_params)
     if @user.save
        session[:user_id] = @user.id # user logs in use the word usage of passing through the session hash 
        redirect_to user_path(@user) # applicationwelcome
     else
        redirect_to '/signup' # render signup form again 
     end 
    end 

    def show
      @user = User.find_by_id(params[:id])
      redirect_to '/' if !@user
    end
    
  private

  def user_params 
      params.require(:user).permit(:username, :email, :password) # user params 
  end
end
