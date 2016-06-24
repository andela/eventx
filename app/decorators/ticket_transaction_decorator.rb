class TicketTransactionDecorator < Draper::Decorator
  delegate_all

  def status 
    (accepted)? 'Inactive': 'Pending'
  end 

  def receiver_email 
    booking.user.email 
  end 

  def payers_name 
    recipient_data = User.find(recipient_id).attributes.symbolize_keys
    [recipient_data[:first_name], recipient_data[:last_name]].join(' ')
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

  # total_amount = 0.0
  #   UserTicket.find(@transaction.tickets).each do |ticket|
  #       @total_amount += ticket.ticket_type.price.to_f 
  #   end

  # def total_amount 
  #   amount = 0.0
  #   UserTicket.find(tickets).each do |ticket|
  #     amount += ticket.ticket_type.price.to_f 
  #   end 
  # end 
end

