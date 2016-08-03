class UserTicket < ActiveRecord::Base
  after_initialize :add_ticket_number

  belongs_to :user
  belongs_to :ticket_type
  belongs_to :booking, counter_cache: true
  belongs_to :scanned_by, class_name: "User", foreign_key: :scanned_by

  def self.used_status(bool)
    where(is_used: bool)
  end

  private

  def add_ticket_number
    self.ticket_number ||= SecureRandom.hex
    self.ticket_number
  end
end
