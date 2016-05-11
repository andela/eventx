require "rails_helper"
require "support/booking_helper"

RSpec.describe BookingsController, type: :controller do
  include BookingHelper
  before do
    sign_in_omniauth
    create_booking
  end

  describe "#index" do
    it "gets bookings if user has booked for an event" do
      get :index
      expect(assigns(:bookings).length).to eq 1
      expect(assigns(:bookings)[0].event.title).to eq "Blessings wedding"
    end

    it "does not get bookings if user has not booked for an event" do
      session[:user_id] = 22
      get :index
      expect(assigns(:bookings)).to be nil
    end
  end

  describe "#scan_ticket" do
    context "searches a valid ticket" do
      it "gets the event of the ticket" do
        xhr :get, :scan_ticket, ticket_no: "MyString", format: :js
        expect(assigns(:user_ticket).booking.event.id).to eq @event.id
        expect(assigns(:user_ticket).booking.event.title).
          to eq "Blessings wedding"
      end
    end

    context "searches an invalid ticket" do
      it "gets the event of the ticket" do
        xhr :get, :scan_ticket, ticket_no: "InvalidTicketNo", format: :js
        expect(flash[:notice]).to eq "Ticket does not exist"
      end
    end
  end

  describe "#use_ticket" do
    context "successfully changes status of ticket" do
      it "gets the event of the ticket" do
        xhr :get, :use_ticket, ticket_no: "MyString", format: :js
        expect(assigns(:user_ticket).is_used).to eq true
      end
    end

    context "already used ticket" do
      it "gets the event of the ticket" do
        xhr :get, :use_ticket, ticket_no: "MyString", format: :js
        xhr :get, :use_ticket, ticket_no: "MyString", format: :js
        expect(flash[:notice]).to eq "Ticket has already been used"
      end
    end
  end
end
