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
    @accept_link = invite_path(1)
    @reject_link = invite_path(0)
    mail to: invite.email, subject: "Invitation to #{@event.title.to_s}"
  end

  private

  def invite_path(accepted)
    host = ENV['app_host']
    "#{host}#{confirm_invite_path(token: @invite.token, accepted: accepted)}"
  end
end
