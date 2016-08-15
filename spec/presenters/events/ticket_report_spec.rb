require "rails_helper"

RSpec.describe Events::TicketReport do
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
    ticket = event.ticket_types.first
    @several_tickets = Events::TicketReport.ticket_types(event)
    @ticket_report = Events::TicketReport.new(ticket)
  end

  describe "#ticket_types" do
    it "returns all ticket types in an array" do
      expect(@several_tickets.count).to eq 2
    end
  end

  describe "#name" do
    it "should return the ticket name" do
      expect(@ticket_report.name).to eq "MyTicket"
    end
  end

  describe "#quantity" do
    it "should return the quantity of tickets" do
      expect(@ticket_report.quantity).to eq 4
    end
  end

  describe "#tickets_sold" do
    it "should returns all tickets sold" do
      expect(@ticket_report.tickets_sold).to eq 1
    end
  end

  describe "#price" do
    context "when asked for the quantity" do
      it "returns total ticket count" do
        expect(@ticket_report.price).to eq 0.0
      end
    end

    context "remains" do
      it "returns count for the remaining tickets" do
        expect(@ticket_report.remains).to eq 3
      end
    end

    context "amount" do
      it "returns total tickets sold for the event" do
        expect(@ticket_report.amount).to eq 0.0
      end
    end
  end
end
