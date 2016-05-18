class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, :all

    if user.event_staffs.present?
      can :scan, Event do |event|
        user == event.event_staffs.find_by(user_id: user.id, role: 1).user
      end
    end

    if user.event_manager?
      can :manage, Event,
          manager_profile_id: user.manager_profile.id
    else
      can :read, Event
    end
  end
end
