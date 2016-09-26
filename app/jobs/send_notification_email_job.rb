class SendNotificationEmailJob < ActiveJob::Base
  queue_as :default

  def perform(user, event)
    @user = user
    NotificationsMailer.new_subscribed_event(@user, event).deliver_later
  end
end
