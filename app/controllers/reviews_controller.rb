class ReviewsController < ApplicationController
  before_action :require_login
  before_action :set_review, only: [:edit, :update, :destroy]

  # def index
  #   @reviews = Review.all
  # end  
  # ^ will be too confusing for users to see all comments at once
    
  def new 
    if params[:tea_id] && @tea = Tea.find_by(id: params[:tea_id])
      @review = Review.new(tea_id: @tea.id)
    else
      redirect_to tea_path(@tea) 
    end
  end
  
  def create # need to refactor 
    @tea = Tea.find_by(id: params[:tea_id])
    @review = Review.new(review_params)
    @review.tea = @tea
    @review.user_id = current_user.id
    if @review.save
        redirect_to tea_path(@tea)
    else
        render :new
    end
  end
  
  def edit
    if @review.user_id != current_user.id
        redirect_to tea_path(@review.tea_id) 
    end
end
  
def update
  if @review.update(review_params)
      redirect_to tea_path(@review.tea_id)
  else
      render :edit
  end
end
  
def destroy
  if @review.user_id == current_user.id
    @review.destroy
    redirect_to tea_path(@review.tea_id)
  else
    redirect_to tea_path(@review.tea_id)
  end
end

  def show
    if Review.find_by(id: params[:id])
      @review = Review.find(params[:id])
  else
      redirect_to reviews_path  # add an alert: could not find the tea
    end
  end

  private

  def review_params
    params.require(:review).permit(:tea_id, :title, :text, :stars)
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
