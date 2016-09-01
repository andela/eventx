module TicketTransactionsHelper
  def action_button(recipient_id)
    current_user.id != recipient_id
  end
end
