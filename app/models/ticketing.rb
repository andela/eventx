class Ticketing
  def checkout_ticket
    transaction = TicketTransaction.find(params[:id]).decorate
    receiver_email = transaction.receiver_email
    amount = total_ticket_amount(transaction)
  end

  def total_ticket_amount(transaction)
    total_amount = 0.0
    UserTicket.find(transaction.tickets).each do |ticket|
      total_amount += ticket.ticket_type.price.to_f
    end
    total_amount
  end

  def reject_ticket_transaction(id)
    transaction = TicketTransaction.find(id)
    UserTicket.find(transaction.tickets).each do |ticket|
      ticket.update(transfered: false)
    end
    transaction.destroy

    "Transaction has been cancelled successfully"
  end

  def ticket_transaction(params)
    params[:ticket_ids].each do |ticket_id|
      UserTicket.find(ticket_id).update(transfered: true)
    end

    transaction = TicketTransaction.create(booking_id: params[:booking_id],
                                           recipient_id: params[:recipient],
                                           tickets: params[:ticket_ids])

    TicketTransactionMailer.transfer_mail(transaction).deliver_now

    { message: "Ticket transfer successful", id: transaction.id, status: 200 }
  end
end
