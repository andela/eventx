require "rails_helper"
require "support/booking_helper"

RSpec.describe EventsController, type: :controller do
  include BookingHelper
  before do
    sign_in_omniauth
    create_booking
  end

  context "#tickets" do
    it "gets the total tickets for all the user events" do
      get :tickets, id: Booking.first.event_id
      expect(assigns(:bookings)[0].user_tickets_count).to eq 2
      expect(assigns(:bookings)[0].event.ticket_types.count).to eq 2
      expect(
        assigns(:bookings)[0].event.ticket_types.last.name
      ).to eq "MyTicket"
    end
  end
end
