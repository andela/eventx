require "support/booking_helper"

RSpec.describe EventsController, type: :controller do
  include BookingHelper
  before do
    sign_in_omniauth
    create_booking
  end

  after do
    ManagerProfile.destroy_all
  end

  # describe "#tickets" do
  #   context "when an event manager or user creates a booking" do
  #     it "gets the total tickets for the events" do
  #       get :tickets, id: Booking.first.event_id
  #       expect(assigns(:bookings)[0].user_tickets_count).to eq 2
  #       expect(assigns(:bookings)[0].event.ticket_types.count).to eq 2
  #       expect(
  #         assigns(:bookings)[0].event.ticket_types.last.name
  #       ).to eq "MyTicket"
  #     end
  #   end
  # end

  # describe "#popular" do
  #   context "when popular events exist" do
  #     it "renders the popular events" do
  #       get :popular

  #       expect(assigns[:events][0].title).to eq "Blessings wedding"
  #       expect(assigns[:events][0].manager_profile_id).to eq 1
  #       expect(assigns[:events].count).to eq 1
  #       expect(response).to render_template "events/popular"
  #     end
  #   end
  # end

  describe "#popular" do
    context "when popular events categories filtered exist" do
      it "renders the popular events of the category filtered" do
        get :popular, category: 1

        expect(assigns[:events][0].category_id).to eq 1
        expect(assigns[:events][0].category.name).to eq "Music"
        expect(response).to render_template "events/popular"
      end
    end
  end

  describe "#popular" do
    context "when popular events categories filtered does not exist" do
      it "renders an error message" do
        get :popular, category: 3

        expect(
          flash[:notice]
        ).to eq no_popular_event
      end
    end
  end
end
