class InviteMailer < ApplicationMailer
  include InvitesHelper
  
  def staff_invitation(invite)
    @greeting = "Hi #{invite.recipient_name}"
    @invite = invite
    @event = invite.event
    @accept_link = accept_or_reject_confirm_path(1)
    @reject_link = accept_or_reject_confirm_path(0)
    mail(to: invite.email, subject: "Invitation to #{@event.title.to_s}")
  end

  def notify_manager(invite)
    @greeting = "Hi #{invite.sender.full_name}"
    @invite = invite
    @status = invite_status invite
    @manage_staff_link = full_path manage_staffs_path(invite.event)
    subject = "Your invitation was #{@status}"
    mail(to: invite.sender.email, subject: subject)
  end
end
