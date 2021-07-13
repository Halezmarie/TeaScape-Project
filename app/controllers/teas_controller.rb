class TeasController < ApplicationController # just like brands 
  before_action :require_login

  def index
    @teas = Tea.all
  end
  
  def show
    if Tea.find_by(id: params[:id])
      @tea = Tea.find(params[:id])
  else
      redirect_to teas_path  # add an alert: could not find the tea
    end
  end
    
  # creates an object instance
  def new # -if the user accesses this via a nested route and if brand is found, @brand will be defined
    if params[:brand_id] && @brand = Brand.find_by(id: params[:brand_id])
      # -create a new tea with a brand association
      @tea = Tea.new(brand_id: @brand.id)
    else
      redirect_to brands_path # put an alert: cant create a tea without a brand
    end
  end
  

  # tries to save it to the database if it is possible - need to refactor 
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
  end
  
  def update
    @tea = Tea.find params[:id] # must set @tea instance variable to tea object in order to perform an update on it
    if @tea.update(tea_params)
      redirect_to teas_path(@tea)
    else
      render :edit
    end
  end
  
  def destroy
  end
  
  private

  def tea_params
    params.require(:tea).permit(:tea, :flavor, :type, :description, :brand_id)
  end

  # setter method so that I can set a value of the instance variable outside of the class
  def set_tea
    @tea = Tea.find(params[:id])
  end
end
