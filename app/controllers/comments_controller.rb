class CommentsController < ApplicationController
  respond_to :json

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment
    else
      render json: comment.errors
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :event_id, :review_id, :body)
  end
end
