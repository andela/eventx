class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can [:read, :tickets, :administer], Event
    can :read, Sponsor

    alias_action :create, :read, :update, to: :cru

    if user.event_staffs.present?
      can :scan, Event do |event|
        user == event.event_staffs.find_by(user_id: user.id, role: 1).user
      end
    end

    staffs = user.event_staffs
    if staffs
      staffs.each do |staff|
        if staff.role == "collaborator"
          can :manage, Event, id: staff.event_id
          can :manage, Task, event_id: staff.event_id
          can :manage, EventStaff, event_id: staff.event_id
          can :manage, Sponsor, event_id: staff.event_id
        end

        if staff.role == "logistics"
          can :cru, Event, id: staff.event_id
          can :manage, Task, event_id: staff.event_id
          can :manage, EventStaff, event_id: staff.event_id
        end

        if staff.role == "sponsor"
          can :read, Event, id: staff.event_id
          can :manage, Task, event_id: staff.event_id
          can :manage, EventStaff, event_id: staff.event_id
        end

        next unless %w(event_staff volunteer gate_keeper).include? staff.role
        can :read, Event, id: staff.event_id
        can :read, Task, event_id: staff.event_id
        can :update, Task, event_id: staff.event_id, user_id: user.id
        can :read, EventStaff, event_id: staff.event_id
      end
    end

    if user.event_manager?
      can :manage, Event, manager_profile_id: user.manager_profile.id
      user.events.each { |event| can :manage, Sponsor, event_id: event.id }
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
