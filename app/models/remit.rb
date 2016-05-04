class Remit < ActiveRecord::Base
  belongs_to :event
  before_save :set_total_amount
  after_create :send_remit_mail
  validate :check_remit_status

  def check_remit_status
    if event.can_request_remit?
      true
    else
      errors.add(:event, "Event cannot yet request a remittance!")
    end
  end

  def set_total_amount
    self.total_amount = event.bookings.sum(:amount)
  end

  def send_remit_mail
    RemitMailer.remitance_confirmation(
      event, event.manager_profile, self
    ).deliver_now
  end
end
