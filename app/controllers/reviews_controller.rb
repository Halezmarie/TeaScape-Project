class ReviewsController < ApplicationController
  before_action :require_login
  before_action :set_review, only: [:edit, :update, :destroy]
  # like a helper 

  def new # creates an object instance, doesnt validate or save it 
    if params[:tea_id] && @tea = Tea.find_by(id: params[:tea_id])
      @review = Review.new(tea_id: @tea.id) # creating a review and associating it with the tea id 
    else
      redirect_to tea_path(@tea) 
    end
  end
  
  def create  # tries to save it to the database if it is possible. validates, saves into the params 
    @tea = Tea.find_by(id: params[:tea_id])
    @review = Review.new(review_params)  # saving it into the database
    @review.tea = @tea #associating it to the review
    @review.user_id = current_user.id  #associating the user id of the review with the current user id of the review
    if @review.save
        redirect_to tea_path(@tea) # show the tea page with the review
    else
        render :new # did not save
    end
  end

  
  def edit
    if @review.user_id != current_user.id
        redirect_to tea_path(@review.tea_id), alert: "You can't edit this review because you didn't make it!"
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
      redirect_to reviews_path, alert: "We can't find this review!" # do I even need this 
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
