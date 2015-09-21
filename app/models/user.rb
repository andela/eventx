class User < ActiveRecord::Base
  # This set the roles of the users
  enum role: [:attendee, :event_staff, :event_manager, :super_admin ]

  #associations
  # has_many :attendees, class: Attendee, foreign_key: 'user_id'
  has_many :events, foreign_key: 'event_manager_id'
  # has_many :events_attending, through: :attendees, source: 'event'

  has_many :bookings
  has_many :user_tickets, through: :bookings
  has_many :events_attending, through: :bookings, source: 'event'

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.profile_url = auth.info.image
      user.first_name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.save!
    end
  end

  def self.auth_name
    if self.info.name == '' || nil?
      return self.info.login
    else
      return self.info.name
    end
  end
end
