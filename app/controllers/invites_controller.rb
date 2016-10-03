class InvitesController < ApplicationController
  before_action :set_invite, only: [:accept, :reject, :cancel]

  def confirm_invite
    @invite = Invite.find_by(token: params[:token])
    @accepted = params[:accepted]
  end

  def accept
    unless invite_already_accepted_or_rejected?
      add_event_staff
    end
  end

  def reject
    unless invite_already_accepted_or_rejected?
      @invite.reject
      notify_event_manager
      notify_recipient invite_rejected(@invite.sender.full_name)
    end
  end

  def cancel
    notify_recipient invite_reply_cancelled(@invite.sender.full_name)
  end

  private

  def set_invite
    @invite = Invite.find_by(id: params[:id])
  end

  def add_event_staff
    recipient = @invite.recipient
    staff_params = { role: @invite.role, user: recipient, event: @invite.event }
    staff = EventStaff.new(staff_params)
    if staff.save
      set_invite_accepted_and_notify
    else
      notify_recipient staff.errors.full_messages.join("; ")
      return
    end
  end

  def set_invite_accepted_and_notify
    @invite.accept
    notify_event_manager
    notify_recipient invite_accepted(@invite.sender.full_name)
  end

  def invite_already_accepted_or_rejected?
    unless @invite.accepted.nil?
      notify_recipient invite_already_replied(@invite.sender.full_name)
      true
    end
  end

  def notify_recipient(message)
    flash[:notice] = message
    redirect_to root_path
  end

  def notify_event_manager
    mail = InviteMailer.notify_manager(@invite)
    mail.deliver_now
  end
end
