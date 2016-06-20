class SubscriptionsController < ApplicationController
  respond_to :json

  def create
    binding.pry
    @subscription = Subscription.new(subscription_params)
    if @subscription.save
      render json: @subscription
    else
      render json: @subscription.errors
    end
  end

  def destroy
    subscription = Subscription.find_by(
      event_id: params[:event_id],
      user_id: current_user.id
    )
    subscription.destroy
    render json: { success: "Successfully unsubscribed from event" }
  end

  private

  def subscription_params
    params.require(:subscription).permit(
      :event_id,
      :manager_profile_id,
      :user_id
    )
  end
end
