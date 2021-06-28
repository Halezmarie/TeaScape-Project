class BrandsController < ApplicationController
  before_action :require_login
  
  def index
    @brands = Brand.all
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

  def brand_params
    params.require(:brand).permit(:name)
  end
end
