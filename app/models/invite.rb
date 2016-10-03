class Invite < ActiveRecord::Base
  include StaffRole

  belongs_to :event
  belongs_to :sender, class_name: "User"

  before_create :generate_token

  def generate_token
    self.token = SecureRandom.hex
  end

  def role_specification
    staff_role_specifications[self.read_attribute(:role)]
  end

  def recipient
    User.find_by(email: email)
  end

  def recipient_name
    (recipient.full_name if recipient) || email[/[^@]+/]
  end

  def accept
    self.update_attributes(accepted: true)
  end

  def reject
    self.update_attributes(accepted: false)
  end
end