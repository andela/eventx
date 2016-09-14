class UpdateEventMailer < ApplicationMailer
  def update_event(subscriber_email, event)
    @event = event

    mail(
      to: subscriber_email,
      subject: "Event changed"
    )
  end
end
