class SendNotificationEmailJob < ActiveJob::Base
  queue_as :default

  def perform(user, event)
    @user = user
    EventMailer.new_subscribed_event(@user, event).deliver_now
  end
end
