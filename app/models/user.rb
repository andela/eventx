class User < ActiveRecord::Base
  # This set the roles of the users
  enum status: [:user, :event_manager]
 # attr_reader :role
  #associations
  # has_many :attendees, class: Attendee, foreign_key: 'user_id'
  # has_many :events, foreign_key: 'event_manager_id'
  # has_many :events_attending, through: :attendees, source: 'event'
  # def initialize(role_id = 0)
  #   @role = status.has_key?(role_id.to_i) ? status[role_id.to_i] : status[0]
  # end


  has_many :bookings
  has_many :user_tickets, through: :bookings
  has_many :events_attending, through: :bookings, source: 'event'
  has_many :event_staffs
  has_many :events, through: :event_staffs
  has_many :authentications


  # def role?(role_name)
  #   role == role_name
  # end

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
