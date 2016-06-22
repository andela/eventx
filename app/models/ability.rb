class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can [:read, :tickets], Event
    can :read, Sponsor

    if user.event_staffs.present?
      can :scan, Event do |event|
        user == event.event_staffs.find_by(user_id: user.id, role: 1).user
      end
    end

    if user.event_manager?
      can :manage, Event, manager_profile_id: user.manager_profile.id
      can :manage, Sponsor
      can :manage, Booking do |booking|
        booking.event.manager_profile_id = user.manager_profile.id
      end
    end

    if user.bookings.present?
      can :request_refund, Booking do |booking|
        booking.event.enabled == false &&
          booking.event.start_date > Time.now &&
          booking.payment_status == "paid"
      end
    end

    can [:create, :paypal_hook, :tickets, :read], Booking
  end
end
