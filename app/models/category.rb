class Category < ActiveRecord::Base
  validates :name, presence: true
  validates_uniqueness_of :name, notice: "Category exists"
  has_many :events
  belongs_to :manager_profile

  scope :list, lambda {
    where(
      "manager_profile_id = ? OR manager_profile_id = ?",
      0, tenant
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
