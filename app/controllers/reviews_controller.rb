class ReviewsController < ApplicationController
  before_action :require_login
  def index
  end
  
  def show
  end
    
  def new
  end
  
  def create
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end

  private

  def review_params
    params.require(:review).permit(:text, :stars)
  end
end
