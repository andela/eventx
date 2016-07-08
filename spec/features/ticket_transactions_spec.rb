require "rails_helper"

RSpec.feature "TicketTransactions", type: :feature, js: true do
  before(:each) do
    @user = create(:user, email: "user@eventx.com")
    @event = create(:event)
    @ticket_types = [build(:ticket_type)]
    @booking = create(:booking, event: @event, user: @user, payment_status: 2, amount: 20)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    create(:user_ticket, ticket_type: @ticket_types[0], booking_id: @booking.id)
  end

  scenario "user views tickets for a particular booking" do
    visit all_tickets_path(@booking.id)
    within '#available_tickets thead' do
      page_should_have_content(["Ticket Number", "Type", "Status"])
    end
    expect(page.current_path).to eq all_tickets_path(@booking.id)
  end
end
