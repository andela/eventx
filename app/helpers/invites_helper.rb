module InvitesHelper
  def accept_or_reject_confirm_path(accepted)
    "#{full_path confirm_invite_path(token: @invite.token, accepted: accepted)}"
  end

  def accept_or_reject_invite
    ("accept" if @accepted == '1') || "reject"
  end

  def invite_status(invite)
    ("accepted" if invite.accepted) || "rejected"
  end

  def invite_path
    return accept_invite_path(@invite) if @accepted == '1'
    reject_invite_path @invite
  end

  def full_path(path)
    "#{ENV['app_host']}#{path}"
  end
end
