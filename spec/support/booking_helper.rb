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
    booking = create(:booking)
    @user = user
    @event = event
    booking.user_id = @user.id
    booking.event_id = @event.id
    booking.save
    ticket_type = create(:ticket_type, event: @event)
    create(:user_ticket, ticket_type: ticket_type, booking: booking)
  end
end
