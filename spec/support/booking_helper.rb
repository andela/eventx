require "rails_helper"
module BookingHelper
  def sign_in_omniauth
    set_valid_omniauth
    OmniAuth.config.test_mode = true
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    request.env["omniauth.auth"]
  end

  def user
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    user
  end

  def event
    manager = create(:manager_profile, user: user)
    event_template = EventTemplate.create(
      name: "purple",
      image: "http://goo.gl/erHIiU"
    )
    create(
      :event, manager_profile: manager,
              event_template: event_template
    )
  end

  def create_booking
    @user = user
    @event = event
    booking = create(:booking)
    booking.user_id = @user.id
    booking.event_id = @event.id
    booking.save

    ticket_type = create(:ticket_type, event: @event)
    create(:user_ticket, ticket_type: ticket_type, booking: booking)

    receiver = create(:user)
    ticket_transactions = create(:ticket_transaction, booking: booking, recipient_id: receiver.id)
  end

  def create_paid_booking
    ticket_type = create(:ticket_type, :paid, event: @event)
    booking = create(:booking, txn_id: "Paid ticket", user: @user, event: @event)
    ticket = create(:user_ticket, ticket_type: ticket_type, booking: booking)
    ticket_transactions = create(:ticket_transaction, tickets: [ticket.id], recipient_id: 2, booking: booking)
  end
end
