class Category < ActiveRecord::Base
  validates :name, presence: true
  has_many :events
  belongs_to :manager_profile
  #remove later
  #has_and_belongs_to_many :subscribers, class_name: "User"
  has_many :notification_subscriptions
  has_many :subscribers, through: :notification_subscriptions, class_name: "User"

  scope :list, lambda {
    where(
      "manager_profile_id = ? OR manager_profile_id = ?",
      0, tenant
    )
  }

  scope :current, lambda {
    where(
      "manager_profile_id = ? OR manager_profile_id = ?",
      0, ActsAsTenant.current_tenant.id
    )
  }

  def self.tenant
    if ActsAsTenant.current_tenant.nil?
      0
    else
      ActsAsTenant.current_tenant.id
    end
  end
end
