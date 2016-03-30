require "rails_helper"

RSpec.describe BookingsController, type: :controller do
  before do
    set_valid_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.test_mode = true
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    manager = create(:manager_profile, user: user)
    event_template = EventTemplate.create(
      name: "purple",
      image: "http://goo.gl/erHIiU"
    )
    category = Category.create(
      name: "Networking", description:
      "Business mixers, hobby meetups, and panel discussions"
    )
    @event = create(
      :event, manager_profile: manager,
              event_template: event_template,
              category: category
    )

    booking = create(:booking)
    booking.user_id = user.id
    booking.event_id = @event.id
    booking.save
  end

  after(:all) do
    User.destroy_all
    Booking.destroy_all
    Event.destroy_all
  end

  context "#each_event_ticket" do
    it "gets bookings if user has booked for an event" do
      get :each_event_ticket, event_id: @event.id
      expect(assigns(:bookings).length).to eq 1
      expect(assigns(:bookings)[0].event_id).to eq @event.id
    end

    it "does not get bookings if user has not booked for an event" do
      session[:user_id] = 22
      get :each_event_ticket, event_id: @event.id
      expect(assigns(:bookings)).to be nil
    end
  end
end
