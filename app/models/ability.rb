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

    if user.manager_profile.present?
      can :new, Event
      can :create, Event
      can :edit, Event do |event|
        user == event.manager_profile.user
      end

      can :update, Event do |event|
        user == event.manager_profile.user
      end
    end
  end
end
