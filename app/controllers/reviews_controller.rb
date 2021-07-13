class ReviewsController < ApplicationController
  before_action :require_login

  def index
    @reviews = Review.all
  end
    
  def new
    if @tea = Tea.find_by_id(params[:tea_id])
      @review = @tea.reviews.build
    else
      @review = Review.new
    end
  end
  
  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to review_path(@review)
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end

  def show
    @review = Review.find_by_id(params[:id])
  end

  private

  def review_params
    params.require(:review).permit(:tea_id, :title, :text, :stars)
  end
end
