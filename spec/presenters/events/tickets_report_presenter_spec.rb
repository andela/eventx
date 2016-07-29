require "rails_helper"

RSpec.describe Events::TicketsReportPresenter do
  before(:each) do
    user = create(:user)
    ticket_types = [
      build(:ticket_type, quantity: 4),
      build(:ticket_type, :paid)
    ]

    event = create(:event, ticket_types: ticket_types)
    booking = create(:booking, event: event, user: user)
    i = 0
    2.times do
      create(:user_ticket,
             ticket_type: ticket_types[i],
             booking_id: booking.id)
      i += 1
    end
    @presenter = Events::TicketsReportPresenter.new(event)
  end

  describe "#all_bookings" do
    it "returns all bookings for a valid event" do
      expect(@presenter.all_bookings.count).to eq 1
    end
  end

  describe "#attendees" do
    it "returns all attendees for a valid event" do
      expect(@presenter.attendees.count).to eq 1
    end
  end

  describe "#ticket_types" do
    it "returns all ticket types for a valid event" do
      expect(@presenter.ticket_types.count).to eq 2
    end
  end

  describe "#calculate_total" do
    context "when asked for the quantity" do
      it "returns total ticket count" do
        expect(@presenter.calculate_total("quantity")).to eq 6
      end
    end

    context "when asked for the remaining ticket" do
      it "returns count for the remaining tickets" do
        expect(@presenter.calculate_total("remains")).to eq 4
      end
    end

    context "when asked for tickets sold" do
      it "returns total tickets sold for the event" do
        expect(@presenter.calculate_total("tickets_sold")).to eq 2
      end
    end

    context "when asked for tickets price" do
      it "returns total tickets price for the event" do
        expect(@presenter.calculate_total("price")).to eq 9.99
      end
    end

    context "when asked for the amount" do
      it "returns total amount for tickets" do
        expect(@presenter.calculate_total("amount")).to eq 9.99
      end
    end
  end
end
