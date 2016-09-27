class EventMailer < ApplicationMailer
  include EventsHelper
  
  def attendance_confirmation(user, event)
    @greeting = "Hi #{user.first_name}"
    @event = event
    mail to: user.email, subject: @event.title.to_s
  end

  def staff_invitation(invite)
    @greeting = "Hi #{invite.recipient_name}"
    @invite = invite
    @event = invite.event
    mail to: invite.email, subject: "Invitation to #{@event.title.to_s}"
  end
end
