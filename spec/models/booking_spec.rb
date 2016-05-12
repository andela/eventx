require "rails_helper"

RSpec.describe Booking, type: :model do
  before(:each) do
    allow(ENV).to receive(:[]).with("paypal_host").
      and_return("https://sandbox.paypal.com")
    allow(ENV).to receive(:[]).with("PAYPAL_BUSINESS").
      and_return("notify@email.com")
    allow(ENV).to receive(:[]).with("app_host").
      and_return("http://sample.com")
    allow(ENV).to receive(:[]).with("paypal_notify_url").
      and_return("http://sample.com/notify")
  end

  let(:my_ticket) do
    user_tickets.ticket_type_id = 1
    user_tickets.booking_id = 1
    user_tickets.ticket_number = Booking.new.instance_eval { add_uniq_id }
  end

  describe "#add_uniq_id" do
    it "generates unique id" do
      expect(Booking.new.instance_eval { add_uniq_id }).not_to be nil
    end
  end

  describe "#calculate_amount" do
    it "calculates amount" do
      booking = create(:booking)
      ticket = create(:ticket_type_paid)
      create(:user_ticket, ticket_type: ticket, booking: booking)
      expect(booking.instance_eval { calculate_amount }).to eql 9.99
    end
  end

  describe "#check_presence_of_tickets" do
    none = ["You cannot save without an ID"]
    it "checks if tickets are present" do
      expect(Booking.new.instance_eval { check_presence_of_tickets }).
        to eql none
    end
  end

  describe "#paypal_url" do
    it "returns appropriate paypal url with" do
      booking = create(:booking, event: create(:event))
      paypal_url = booking.paypal_url("/paypal_hook")
      expect(paypal_url).to eql("#{ENV['paypal_host']}/cgi-bin/webscr?amount=0"\
      "&business=notify%40email.com&cmd=_xclick&invoice=#{booking.uniq_id}&"\
      "item_name=Ticket+for+Blessings+wedding&item_number=1&"\
      "notify_url=http%3A%2F%2Fsample.com%2Fnotify%2Fpaypal_hook&"\
      "return=http%3A%2F%2Fsample.com%2Fpaypal_hook")
    end

    it "returns paypal validate url" do
      expect(Booking.validate_url).to eql("#{ENV['paypal_host']}/cgi-bin/"\
      "webscr?cmd=_notify-validate")
    end
  end
end
