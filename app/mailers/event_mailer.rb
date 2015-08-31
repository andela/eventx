class EventMailer < ApplicationMailer

  def attendance_confirmation(user, event)
    @greeting = "Hi #{user.first_name}"
    @event = event
    mail to: user.email, subject: "#{@event.title}"
  end
end
