class ManagerProfile < ActiveRecord::Base
  belongs_to :user
  has_many :events
  has_many :categories
  has_many :subscriptions
  has_many :subscribers, through: :subscriptions, source: :user

  validates :company_name, presence: true
  validates :subdomain, presence: true, uniqueness: true, format: {
    with: /\A([a-zA-Z]+)/ }
  validates :company_mail, presence: true, uniqueness: true, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
end
