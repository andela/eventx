class TicketTransaction < ActiveRecord::Base
  belongs_to :booking 
  belongs_to :user 

  serialize :tickets 

  def self.pending(id) 
    where(accepted: false, booking_id: id)
  end 
  

  # def pay_pal_url(options, return_url)
  #   receiver_email = options[:receiver_email]
  #   amount = options[:total_amount]
  #   current_code = "USD"
  #   cancelUrl = "/ticket_transactions/path"
  #   returnUrl = "/tickets"
  #   fields = {
  #     actionType: 'PAY'
  #     receiverList.receiver(0).email:
  #   }

  #   "https://www.paypal.com/cgi-bin/webscr?cmd=_ap-payment&paykey=value"
  # end 
end
