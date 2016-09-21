class EventMailer < ApplicationMailer
  def attendance_confirmation(user, event)
    @greeting = "Hi #{user.first_name}"
    @event = event
    mail to: user.email, subject: @event.title.to_s
  end

  def new_subscribed_event(user, event)
    puts "In the mail method **********************************************"
    @user = user
    @event = event
    mail to: @user.email, subject: "New #{event.title} event "
    puts "After sending mail"
  end
end
