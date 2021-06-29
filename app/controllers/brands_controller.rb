class BrandsController < ApplicationController
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
    @brand.user_id = session[:user_id]
      if brand.save
        redirect_to brand_path(@brand)
      else
        render :new
      end
  end

  def edit
  end

  def update
    if @brand.update(brand_params)
      redirect_to brand_path(@brand)
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
end
