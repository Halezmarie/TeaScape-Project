class BrandsController < ApplicationController
  before_action :set_brand, only:[:show, :edit, :update]
  before_action :require_login
  
  def index
    @brands = Brand.all
  end

  def show
  end
  
  def new
    @brand = Brand.new
  end

  def create
    brand = Brand.new(brand_params)
    
      if brand.save
        redirect_to brands_path(@brand)
      else
        render :new
      end
  end

  def edit
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
      params.require(:brand).permit(:name)
  end

  def set_brand
    @brand = Brand.find(params[:id])
  end
end
