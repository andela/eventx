class Booking < ActiveRecord::Base
  before_create :add_uniq_id
  before_save :calculate_amount

  belongs_to :user
  belongs_to :event
  has_many :user_tickets, dependent: :destroy
  accepts_nested_attributes_for :user_tickets
  enum payment_status: [ :unpaid, :free, :paid ]

  def paypal_url(return_path)
    values = {
        business: ENV['PAYPAL_BUSINESS'],
        cmd: "_xclick",
        return: "#{ENV['app_host']}#{return_path}",
        invoice: self.uniq_id,
        amount: self.amount,
        item_name: "Ticket for #{event.title}",
        item_number: id,
        notify_url: "#{ENV['paypal_notify_url']}/paypal_hook"
    }
    "#{ENV['paypal_host']}/cgi-bin/webscr?" + values.to_query
  end

  def self.validate_url
    "#{ENV['paypal_host']}/cgi-bin/webscr?cmd=_notify-validate"
  end

  private
    def calculate_amount
      cost = 0
      user_tickets.includes(:ticket_type).each{ |ticket|
        cost += ticket.ticket_type.price.to_f
      }
      self.amount = cost
    end

    def add_uniq_id
      self.uniq_id = SecureRandom.hex #.uuid.gsub(/\-/)
    end

    def check_presence_of_tickets
      errors.add(:user_tickets, "You cannot save without an ID")if user_tickets.blank?
    end

end
