class BrandsController < ApplicationController
  before_action :set_brand, only:[:show, :edit, :update]
  before_action :require_login
  # before_action :set_brand_ids, only: [:show, :edit, :update] # show edit link if user made the brand
 


  def index
    @brands = Brand.all # showing all of the brands that have been created 
    @brands = Brand.by_name(params[:search]) # my search bar 
  end

  def show
    if Brand.find_by_id(params[:id]) 
      @brand = Brand.find_by_id(params[:id])
      # if the brand of tea is present show it
    else
      redirect_to brands_path, alert: "This brand of tea does not exist! Maybe you can make it?" # why do I have to comment out set brand ids for this to work?
    end
  end
  
  def new  # creates an object instance, doesnt validate or save it 
    @brand = Brand.new
  end

  def create # tries to save it to the database if it is possible. validates, saves into the params 
    @brand = Brand.find_by(id: params[:brand_id])   
    @brand = Brand.new(brand_params) # saving it into the database
    @brand.user_id = current_user[:id] #associating the user id of the brand with the current user id of the bra
      if @brand.save
        redirect_to brands_path(@brand) # show the brand on the list of brands 
      else
        render :new # did not save 
      end
  end

  def edit
    if @brand.user_id != current_user.id # if it is not the current user 
      redirect_to brands_path, alert: "You are not the owner of this brand of tea!"
    end
  end
    
  def update # must set @brand instance variable to point appropriate brand object in order to perform any update on it
    if @brand.update(brand_params) # then let it be saved to edit 
      redirect_to brands_path(@brand)
    else
      render :edit  # if it does not meet the correct brand params for the update, render the edit form again 
    end
  end

  def destroy
  end

  private

  def brand_params # look more into params 
      params.require(:brand).permit(:name, :search, :user_id)
  end

  def set_brand # like a helper, setting what @brand is without having to state it each time. the instance of Brand is being found by the brand id 
    @brand = Brand.find_by_id(params[:id])
  end

  # # Setter methods so that I can set a value of the instance variable outside of the class 
  # def set_brand_ids
  #   @brand.user_id == current_user.id
  # end
end
