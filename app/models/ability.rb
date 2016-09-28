class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can [:read, :tickets, :administer], Event
    can :read, Sponsor
    can :manage, Task

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

    event ||= Event.new
    event_staff = EventStaff.find_by(user_id: user.id, event_id: event.id)
    if event_staff.present?
      if event_staff.super_admin?
        can :manage, [event, Task, event.event_staffs]
      elsif event_staff.event_manager?
        can :update, Event
        can :crud, [Task, EventStaff]
      elsif event_staff.sponsor?
        can :read, [Event, EventStaff]
        can :crud, [Task]
      elsif event_staff.volunteer?
        can :read, [Event, EventStaff]
        can :cru, [Task], user_id: user.id
      elsif event_staff.gate_keeper?
        can :read, [Event, EventStaff]
        can :cru, [Task], user_id: user.id
      end
    end

    can [:create, :paypal_hook, :tickets, :read], Booking
  end
end
