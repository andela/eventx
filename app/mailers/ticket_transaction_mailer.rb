class TicketTransactionMailer < ApplicationMailer
  def transfer_mail(transaction)
    recipient_data = User.find(transaction.recipient_id).
                     attributes.symbolize_keys
    @recipient_email = recipient_data[:email]
    @recipient_name = [recipient_data[:first_name],
                       recipient_data[:last_name]].join(" ")

    booking = transaction.booking
    sender_data = booking.user.attributes.symbolize_keys
    @sender_name = [sender_data[:first_name],
                    sender_data[:last_name]].join(" ")

    event_data = booking.event
    @event_title = event_data.title
    @event_description = event_data.description
    @event_start_date = event_data.start_date
    @event_end_date = event_data.end_date
    @no_of_tickets = transaction.tickets.size
    @status = transaction.accepted ? "Sold" : "Pending"
    @transaction_id = transaction.id
    @amount = Ticketing.new.ticket_amount(transaction)

    mail(to: @recipient_email, subject: "Request for Ticket Transfer")
  end
end
