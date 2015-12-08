class User < ActiveRecord::Base
  has_many :bookings
  has_many :user_tickets, through: :bookings
  has_many :events_attending, through: :bookings, source: "event"
  has_many :event_staffs
  has_one :manager_profile
  has_many :events, through: :manager_profile

  def self.from_omniauth(auth)
    provider = auth["provider"]
    where(provider: provider, uid: auth["uid"]).first_or_create do |user|
      user.provider = provider
      user.uid = auth["uid"]
      user.profile_url = auth["info"][:image]
      user.first_name = auth["info"][:name]
      user.email = auth["info"][:email]
      user.save!
    end
  end

  def event_manager?
    !manager_profile.nil?
  end

  def generate_auth_token
    user = self
    payload = { user_id: user.id, email: user.email }
    AuthToken.encode(payload)
  end
end
