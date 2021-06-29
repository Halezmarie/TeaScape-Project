class TeasController < ApplicationController # just like brands 
  before_action :require_login

  def index
    @teas = Tea.all
  end
  
  def show
  end
    
  def new
    @tea =Tea.new
  end
  
  def create
    tea = Tea.new(tea_params)
    if tea.save
      redirect_to teas_path(@tea)
    else
      render :new 
    end
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

  def set_tea
    @tea = Tea.find(params[:id])
  end
end
