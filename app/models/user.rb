class User < ActiveRecord::Base
  # This set the roles of the users
  enum role: [:attendee, :event_staff, :event_manager, :super_admin ]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      puts "auth request ", auth.inspect
      user.provider = auth.provider
      user.uid = auth.uid
      user.profile_url = auth.info.image
      user.first_name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_token_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end


