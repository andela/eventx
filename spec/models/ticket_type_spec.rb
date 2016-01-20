require "rails_helper"

RSpec.describe TicketType, type: :model do
  it "should have a valid factory" do
    tic_type = FactoryGirl.build(:ticket_type)
    expect(tic_type).to be_valid
  end

  describe "" do
    before(:each) do
      @ticket_type = FactoryGirl.create(:ticket_type_paid)
      FactoryGirl.create(:user_ticket, ticket_type: @ticket_type)
    end

    describe "#sold" do
      it "returns the number of ticket sold" do
        expect(@ticket_type.sold).to eql 1
      end
    end

    describe "#total_amount_sold" do
      it "returns the amount of ticket sold" do
        expect(@ticket_type.total_amount_sold).to eql 9.99
      end
    end

    describe "#tickets_left" do
      it "returns the number of ticket unsold" do
        expect(@ticket_type.tickets_left).to eql 0
      end
    end
  end
end
