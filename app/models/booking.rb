class Booking < ActiveRecord::Base
  attr_accessor :event_source

  before_create :add_uniq_id
  before_save :calculate_amount
  after_update :send_mail

  belongs_to :user
  belongs_to :event
  has_many :user_tickets, dependent: :destroy
  accepts_nested_attributes_for :user_tickets
  enum payment_status: [:unpaid, :free, :paid]

  def paypal_url(return_path)
    values = {
      business: ENV["PAYPAL_BUSINESS"],
      cmd: "_xclick",
      return: "#{ENV['app_host']}#{return_path}",
      invoice: uniq_id,
      amount: amount,
      item_name: "Ticket for #{event.title}",
      item_number: id,
      notify_url: "#{ENV['paypal_notify_url']}/paypal_hook"
    }
    "#{ENV['paypal_host']}/cgi-bin/webscr?" + values.to_query
  end

  def self.validate_url
    "#{ENV['paypal_host']}/cgi-bin/webscr?cmd=_notify-validate"
  end

  def to_partial_path
    "bookings/ticket"
  end

  def send_mail
    if refund_requested_changed? && refund_requested
      BookingMailer.request_refund(self, ENV["app_host"]).deliver_now
    end

    if granted_changed? && granted
      BookingMailer.grant_refund(self, ENV["app_host"]).deliver_now
    end
  end

  private

  def calculate_amount
    cost = 0
    user_tickets.includes(:ticket_type).each do |ticket|
      cost += ticket.ticket_type.price.to_f
    end
    self.amount = cost
  end

  def add_uniq_id
    self.uniq_id = SecureRandom.hex
  end

  def check_presence_of_tickets
    presence = user_tickets.blank?
    errors.add(:user_tickets, "You cannot save without an ID") if presence
  end
end
