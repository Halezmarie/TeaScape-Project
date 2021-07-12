class BrandsController < ApplicationController
  before_action :set_brand, only:[:show, :edit]
  #  set a value of an instance variable outside the class
  before_action :require_login
  
  
  def index
    @brands = Brand.all
  end

  def show
    if Brand.find_by(id: params[:id])
      @brand = Brand.find(params[:id])
      # if the tea of brand is present show it
    else
      redirect_to brands_path # if not, "could not find the brand of tea" add alert here 
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
  end

  def update
    @brand = Brand.find params[:id] # must set @brand instance variable to point appropriate brand object in order to perform anYYupdate on it
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
      params.require(:brand).permit(:name)
  end

  def set_brand
    @brand = Brand.find(params[:id])
  end

  # Setter methods so that I can set a value of the instance variable outside of the class 
  def set_brand_ids
    @brand_ids = current_user.brands.collect{|tea| tea.brand_id}.uniq
  end
end
