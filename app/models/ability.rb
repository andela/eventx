class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new 
      if user.is_an_event_manager?
        can :manage, Event
      else
        can :read, :all
      end
  end
end
  