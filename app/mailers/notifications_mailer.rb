class NotificationsMailer < ApplicationMailer
  def new_subscribed_event(user, event)
    @user = user
    @event = event

    mail to: @user.email, subject: "New #{event.category.name} event"
  end
end
