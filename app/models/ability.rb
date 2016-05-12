class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can [:read, :tickets], Event

    if user.event_staffs.present?
      can :scan, Event do |event|
        user == event.event_staffs.find_by(user_id: user.id, role: 1).user
      end
    end

    if user.event_manager?
      can [:update, :edit, :destroy, :enable, :disable],
          Event,
          manager_profile_id: user.manager_profile.id
      can [:create, :new], Event
    end

    if user.bookings.present?
      can :request_refund, Booking do |booking|
        booking.event.enabled == false &&
          booking.event.start_date > Time.now &&
          booking.payment_status == "paid"
      end
    end

    can :create, Booking
    can :paypal_dummy, Booking
  end
end
