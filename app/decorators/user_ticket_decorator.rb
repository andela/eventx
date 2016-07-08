class UserTicketDecorator < Draper::Decorator
  delegate_all

  def status
    (is_used) ? "INVALID" : "VALID"
  end

  def name
    ticket_type.name
  end
end
