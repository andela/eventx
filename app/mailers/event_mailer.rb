class EventMailer < ApplicationMailer
  def attendance_confirmation(user, event)
    @greeting = "Hi #{user.first_name}"
    @event = event
    mail to: user.email, subject: @event.title.to_s
  end

  def new_subscribed_event(user, event)
    @user = user
    @event = event

    mail to: @user.email, subject: "New #{event.category.name} event "
  end
end
