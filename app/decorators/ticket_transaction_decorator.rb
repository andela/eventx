class TicketTransactionDecorator < Draper::Decorator
  delegate_all

  def status
    accepted ? "Inactive" : "Pending"
  end

  def receiver_email
    booking.user.email
  end

  def payers_name
    user = User.find(recipient_id)
    user.first_name.to_s + user.last_name.to_s
  end

  def payers_email
    User.find(recipient_id).email
  end

  def event
    booking.event.title
  end

  def ticket_count
    tickets.size
  end

  def event_id
    booking.event.id
  end
end
