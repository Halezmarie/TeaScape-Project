class TeasController < ApplicationController
    
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

  def tea_params
    params.require(:tea).permit(:flavor, :type, :description)
  end
end
