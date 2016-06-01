class SubscriptionsController < ApplicationController
  respond_to :js

  def new
    @subscription = Subscription.new()
  end

  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save
      flash[:success] = "You been subscribed to this event"
    else
      flash[:error] = "Unable to subscribe to this event"
    end
  end

  def destroy
    subscription = Subscription.find_by(
      event_id: params[:event_id],
      user_id: current_user.id
    )
    subscription.destroy
    flash[:success] = "You unsubscribed from this event"
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
