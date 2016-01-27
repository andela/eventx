class User < ActiveRecord::Base
  has_many :bookings
  has_many :user_tickets, through: :bookings
  has_many :events_attending, through: :bookings, source: "event"
  has_many :event_staffs
  has_one :manager_profile
  has_many :events, through: :manager_profile

  def self.from_omniauth(auth)
    return auth unless auth
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

  def self.lookup_email(email)
    where(arel_table[:email].matches("%#{email}%")).limit(5).
      pluck(:email, :id).map do |mail, id|
      { "value": mail, "data": id }
    end
  end

  def event_manager?
    !manager_profile.nil?
  end

  def generate_auth_token
    payload = { user_id: id, email: email }
    AuthToken.encode(payload)
  end
end
