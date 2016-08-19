class NewEventMailer < ApplicationMailer
  def new_event(subscriber_email, event)
    @event = event
    mail(
      to: subscriber_email,
      subject: "Your favourite manager created a new event"
    )
  end
end
