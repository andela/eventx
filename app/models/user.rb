class User < ActiveRecord::Base
  has_many :bookings
  has_many :user_tickets, through: :bookings
  has_many :events_attending, through: :bookings, source: "event"
  has_many :event_staffs
  has_one :manager_profile
  has_many :events, through: :manager_profile

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.profile_url = auth.info.image
      user.first_name = auth.info.name
      user.email = auth.info.email
      user.save!
    end
  end

  # def self.auth_name
  #   if self.info.name == "" || nil?
  #     return self.info.login
  #   else
  #     return self.info.name
  #   end
  # end

  def is_an_event_manager?
   !self.manager_profile.nil?
  end
end
