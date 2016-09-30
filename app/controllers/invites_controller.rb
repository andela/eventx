class InvitesController < ApplicationController
  def confirm_invite
    @invite = Invite.find_by(token: params[:token])
    @accepted = params[:accepted]
  end

  def accept
    invite = Invite.find_by(id: params[:id])
    accepted = params[:accepted]
    if invite.accepted.present?
      notify_recipient("You have already replied to #{invite.sender.full_name}'s offer")
    else
      if accepted == "1"
        invite.accepted = params[:accepted]
        invite.save
        add_event_staff_and_notify invite
      else
        notify_event_manager_of_rejection
        notify_recipient("You have rejected #{invite.sender.full_name}'s offer")
      end
    end
  end

  def cancel
    invite = Invite.find_by(id: params[:id])
    notify_recipient("You have not replied to #{invite.sender.full_name}'s offer")
  end

  private

  def add_event_staff_and_notify(invite)
    staff = EventStaff.new(
      role: invite.role,
      user: invite.recipient,
      event: invite.event
    )
    if staff.save
      notify_event_manager_of_acceptance
    else
      notify_recipient(staff.errors.full_messages.join("; "))
      return
    end
    notify_recipient("You have accepted #{invite.sender.full_name}'s offer")
  end

  def notify_recipient(message)
    flash[:notice] = message
    redirect_to(root_path)
  end

  def notify_event_manager_of_rejection

  end

  def notify_event_manager_of_acceptance

  end

  # def invite_params
  #   params.require(:invite).permit(:id, :token, :accepted)
  # end
end
