class User < ActiveRecord::Base
  has_many :bookings
  has_many :user_tickets, through: :bookings
  has_many :events_attending, through: :bookings, source: "event"
  has_many :event_staffs
  has_one :manager_profile
  has_many :events, through: :manager_profile
  has_many :reviews, dependent: :destroy
  has_many :tasks
  has_many :assisted_events, through: :event_staffs, source: "event"

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
      { "value" => mail, "data" => id }
    end
  end

  def event_manager?
    !manager_profile.nil?
  end

  def self.user_info(parameter)
    if parameter[:user_id].nil?
      { error: "Field is empty" }
    else
      user_role = user_role(parameter[:role])
      user_data = user_hash(parameter).merge(user_role: user_role)
      parameter.merge(user_data).symbolize_keys
    end
  end

  def user_tickets_for_event(event_id)
    bookings.where(
      event_id: event_id
    ).order(id: :desc).decorate
  end

  def generate_auth_token
    payload = { user_id: id, email: email }
    AuthToken.encode(payload)
  end

  def self.user_role(role)
    role.split("_").map(&:capitalize).join(" ")
  end

  def self.user_hash(params)
    user = User.where(id: params[:user_id]).pluck(:first_name, :email,
                                                  :profile_url).first
    { first_name: user[0], email: user[1], profile_url: user[2] }
  end

  def self.get_user_events(user_id)
    booking = Booking.where(user_id: user_id).pluck(:event_id)
    Event.find(booking)
  end

  def self.get_team_events(user)
    user_events = []
    user.event_staffs.each do |position|
      user_events.push(Event.find(position.event_id))
    end
    user_events
  end
end
