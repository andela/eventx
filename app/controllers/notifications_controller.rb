class NotificationsController < ApplicationController
  before_action :find_notification, only: [:destroy, :show, :update]
  def new
  end

  def create
    @subscription = NotificationSubscription.new(notification_params)
    if @subscription.save
      flash[:notice] = new_subscription(@subscription.category.name)
      redirect_to dashboard_settings_path
    else
      redirect_to dashboard_path
    end
  end

  def edit
  end

  def update
  end

  def destroy
    flash[:notice] = if @notification.destroy
                        subcription_cancelled(@notification.category.name)
                      else
                        error_occured
                      end
    redirect_to dashboard_settings_path
  end

  private
  def notification_params
    params.require(:notification_subscription).
      permit(:user_id, :category_id, :email_notification)
  end

  def find_notification
    @notification =NotificationSubscription.find(params[:id])
  end
end
