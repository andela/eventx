class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new 
      if user.event_manager?
        can :manage, Event
      else
        can :read, :all
      end
  end
end
  