class ReviewsController < ApplicationController
  def create
    review = Review.new(review_params)
    if review.save
      respond_to do |format|
        format.json { render json: review }
      end
    else
      respond_to do |format|
        format.json { render json: review }
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:body, :event_id, :rating, :user_id)
  end
end
