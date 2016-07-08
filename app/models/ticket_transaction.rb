class TicketTransaction < ActiveRecord::Base
  belongs_to :booking
  serialize :tickets

  def self.pending(id)
    where(accepted: false, booking_id: id)
  end

  def pay_pal_url(pay_info)
    values = {
      business: pay_info[:transaction].receiver_email,
      cmd: "_xclick",
      return: "#{ENV['app_host']}#{pay_info[:return_path]}",
      invoice: pay_info[:transaction].id,
      amount: pay_info[:amount],
      item_name: "Ticket(s) for the #{pay_info[:transaction].event} event",
      item_number: pay_info[:transaction].id,
      quantity: pay_info[:transaction].ticket_count,
      notify_url: "#{ENV['app_host']}/ticket_transaction_hook"
    }

    "#{ENV['paypal_host']}/cgi-bin/webscr?" + values.to_query
  end

  def self.validate_url
    "#{ENV['paypal_host']}/cgi-bin/webscr?cmd=_notify-validate"
  end
end
