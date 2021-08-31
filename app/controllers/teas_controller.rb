class TeasController < ApplicationController 
  before_action :require_login
  before_action :set_tea, only: [:edit, :update, :destroy]

  # refactor these, probably need 1 or 2 at the most 
  def index
    if params[:brand_id]
      if Brand.find_by(id: params[:brand_id])
          @teas = Brand.find(params[:brand_id]).teas
      else
          redirect_to brands_path, alert: "Uh oh! TeaScape can't find that brand of tea!"
    end
      else 
    @teas = Tea.all 
    @teas = Tea.by_flavor(params[:search])
      end
  end
  
  def show
    if Tea.find_by(id: params[:id]) 
      @tea = Tea.find(params[:id])
      @reviews = @tea.reviews 
  else
      redirect_to teas_path, alert: "This flavor of tea doesn't exist! Maybe you can make it?"
    end
  end
    
  def new 
    if params[:brand_id] && @brand = Brand.find_by(id: params[:brand_id])
      @tea = Tea.new(brand_id: @brand.id)
    else
      redirect_to brands_path, alert: "You can't create a tea without a brand"
    end
  end
  
  def create
    @brand = Brand.find_by(id: params[:brand_id])
    @tea = Tea.new(tea_params) 
    @tea.brand = @brand  
    @tea.user_id = current_user[:id] 
    if @tea.save
        redirect_to tea_path(@tea) 
    else
        render :new
    end
  end


  def edit
    if @tea.user_id != current_user.id  
        redirect_to tea_path(@tea), alert: "You can't edit this tea unless you created it!"
    end
end
  
  def update
    if @tea.update(tea_params) 
        redirect_to tea_path(@tea)
    else
        render :edit
    end
end
  
 def destroy
    if @tea.user_id == current_user.id 
      @tea.destroy
      redirect_to teas_path, alert: "You sucessfully deleted the flavor of tea!"
    else
      redirect_to tea_path(@tea), alert: "You can't delete this tea because you did not make it!"
    end
  end
  
  private

  def tea_params
    params.require(:tea).permit(:tea, :flavor, :type, :description, :brand_id, :search)
  end

  def set_tea
    @tea = Tea.find(params[:id])
  end
end
