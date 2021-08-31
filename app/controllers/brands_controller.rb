class BrandsController < ApplicationController
  before_action :set_brand, only:[:show, :edit, :update]
  before_action :require_login

  def index
    @brands = Brand.all 
    @brands = Brand.by_name(params[:search]) 
  end

  def show
    if !@brand 
      redirect_to brands_path, alert: "This brand of tea does not exist! Maybe you can make it?"
    end
  end
  
  def new 
    @brand = Brand.new
  end


  def create   
    # @brand = Brand.new(brand_params) 
       @brand = current_user.brands.build(brand_params) 
    # @brand.user_id = current_user[:id] 
      if @brand.save
        redirect_to brands_path(@brand) 
      else
        render :new 
      end
  end

  def edit
    if @brand.user_id != current_user.id 
      redirect_to brands_path, alert: "You are not the owner of this brand of tea!"
    end
  end
    
  def update 
    if @brand.update(brand_params) 
      redirect_to brands_path(@brand)
    else
      render :edit 
    end
  end

  def destroy
  end

  private 

  def brand_params 
      params.require(:brand).permit(:name, :search, :user_id)
  end

  def set_brand 
    @brand = Brand.find_by_id(params[:id])
  end
  
end
