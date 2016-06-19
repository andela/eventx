class ReviewsController < ApplicationController
  respond_to :json

  def create
    review = Review.new(review_params)
    if review.save
      render json: review
    else
      render json: review.errors
    end
  end

  private

  def review_params
    params.require(:review).permit(:body, :event_id, :rating, :user_id)
  end
end
