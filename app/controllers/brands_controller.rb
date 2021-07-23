class BrandsController < ApplicationController
  before_action :set_brand, only:[:show, :edit, :update]
  before_action :require_login
  #  set a value of an instance variable outside the class

  before_action :set_brand_ids, only: [:show, :edit, :update] # show edit link if user made the brand
 
  
  
  
  def index
    @brands = Brand.all
    @brands = Brand.by_name(params[:search])
    
  end

  def show
    if Brand.find_by(id: params[:id])
      @brand = Brand.find(params[:id])
      # if the tea of brand is present show it
    else
      redirect_to brands_path, alert: "This tea does not exist! Maybe you can make it?" 
    end
  end
  
  def new  # creates an object instance
    @brand = Brand.new
  end

  def create  # tries to save it to the database if it is possible
    @brand = Brand.new(brand_params)
      if @brand.save
        redirect_to brands_path(@brand)
      else
        render :new # did not save 
      end
  end

  def edit
    if @brand_id != current_user.id
      redirect_to brands_path, alert: "You can't edit this, you did not make this tea!"
    end
  end
    
  def update # must set @brand instance variable to point appropriate brand object in order to perform any update on it
    # if @brand_id != current_user.id
      
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
      params.require(:brand).permit(:name, :search)
  end

  def set_brand
    @brand = Brand.find(params[:id])
  end

  # Setter methods so that I can set a value of the instance variable outside of the class 
  def set_brand_ids
    @brand_id = current_user.id
  end
end
