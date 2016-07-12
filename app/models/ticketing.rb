class Ticketing
  def initiate_transfer(params)
    params[:ticket_ids].each do |ticket_id|
      UserTicket.find(ticket_id).update(transfered: true)
    end

    transaction = TicketTransaction.create(booking_id: params[:booking_id],
                                           recipient_id: params[:recipient],
                                           tickets: params[:ticket_ids])

    TicketTransactionMailer.transfer_mail(transaction).deliver_now

    { message: "Ticket transfer successful", id: transaction.id, status: 200 }
  end

  def reject_transfer(id)
    transaction = TicketTransaction.find(id)
    UserTicket.find(transaction.tickets).each do |ticket|
      ticket.update(transfered: false)
    end
    transaction.destroy

    "Transaction has been cancelled successfully"
  end

  def approve_transfer(params)
    transaction = TicketTransaction.find(params[:transaction_id])
    transaction.update(accepted: true)
    @tickets = UserTicket.find(transaction.tickets)
    payer = User.find_by_email(params[:payer_email])

    @booking = Booking.new
    @booking.user_id = payer.id
    @booking.event_id = transaction.booking.event.id
    @booking.payment_status = "paid"
    @tickets.each { |ticket| ticket.update(transfered: false) }
    @booking.save

    @booking.user_tickets << @tickets
  end

  def total_ticket_amount(transaction)
    total_amount = 0.0
    UserTicket.find(transaction.tickets).each do |ticket|
      total_amount += ticket.ticket_type.price.to_f
    end
    total_amount
  end
end
