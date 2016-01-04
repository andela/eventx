require "rails_helper"

RSpec.describe Booking, type: :model do

  # let(:user_tickets){ UserTicket.new }
  let(:my_ticket){
    user_tickets.ticket_type_id = 1
    user_tickets.booking_id = 1
    user_tickets.ticket_number = Booking.new.instance_eval{add_uniq_id}
  }
  describe "#add_uniq_id" do
    it "generates unique id" do
      expect(Booking.new.instance_eval{add_uniq_id}).not_to be nil
    end
  end

  describe "#calculate_amount" do
    it "calculates amount" do
      booking = Booking.new
      ticket = FactoryGirl.create(:ticket_type)
      FactoryGirl.create(:user_ticket, ticket_type: ticket, booking: booking)
      expect(booking.instance_eval do
        calculate_amount
      end
      ).to eql 9.99
    end
  end

  describe "#check_presence_of_tickets" do
    none = ["You cannot save without an ID"]
    it "checks if tickets are present" do
      expect(Booking.new.instance_eval{check_presence_of_tickets}).to eql none
    end
  end
end

# create_table "user_tickets", force: :cascade do |t|
#   t.integer  "ticket_type_id"
#   t.string   "ticket_number"
#   t.datetime "created_at",     null: false
#   t.datetime "updated_at",     null: false
#   t.integer  "booking_id"
# end
