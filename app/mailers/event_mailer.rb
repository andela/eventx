class EventMailer < ApplicationMailer
  include EventsHelper
  
  def attendance_confirmation(user, event)
    @greeting = "Hi #{user.first_name}"
    @event = event
    mail to: user.email, subject: @event.title.to_s
  end
end
