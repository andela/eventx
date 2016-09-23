class NotificationsController < ApplicationController
  before_action :find_notification, only: [:destroy, :show, :update]
  def new
  end

  def create
    @subscription = NotificationSubscription.new(notification_params)
    @subscription.user_id = current_user.id
    if @subscription.save
      redirect_to controller: 'users', action: 'settings'
    else
      redirect_to controller: 'users', action: 'show'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    if @notification.destroy
      redirect_to :back
    else
      redirect_to controller: 'users', action: 'show'
    end
  end

  private
  def notification_params
    params.require(:notification_subscription).permit(:user_id, :category_id, :email_notification)
  end

  def find_notification
    @notification =NotificationSubscription.find(params[:id])
  end
end
