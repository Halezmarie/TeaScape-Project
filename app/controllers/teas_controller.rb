class TeasController < ApplicationController # just like brands 
  before_action :require_login
  before_action :set_tea, only: [:edit, :update, :destroy]

  def index
    if params[:brand_id]
      if Brand.find_by(id: params[:brand_id])
          @teas = Brand.find(params[:brand_id]).teas
      else
          redirect_to brands_path, alert: "Uh oh! TeaScape can't find that brand of tea!"
      end
    else 
    @teas = Tea.all # show ALL the teas 
    @teas = Tea.by_flavor(params[:search])
    end
  end
  
  def show
    if Tea.find_by(id: params[:id])
      @tea = Tea.find(params[:id])
      @reviews = @tea.reviews # show the reviews for the teas
  else
      redirect_to teas_path, alert: "This flavor of tea doesn't exist! Maybe you can make it?"
    end
  end
    
  # creates an object instance
  def new # -if the user accesses this via a nested route and if brand is found, @brand will be defined
    if params[:brand_id] && @brand = Brand.find_by(id: params[:brand_id])
      # -create a new tea with a brand association
      @tea = Tea.new(brand_id: @brand.id)
    else
      redirect_to brands_path, alert: "You can't create a tea without a brand"
    end
  end
  

  # tries to save it to the database if it is possible. validates, saves into the params 
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

  # setter method so that I can set a value of the instance variable outside of the class
  def set_tea
    @tea = Tea.find(params[:id])
  end
end
