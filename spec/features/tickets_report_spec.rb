require "rails_helper"

RSpec.feature "TicketsReport", type: :feature, js: true do
  before(:each) do
    user = create(:user)
    manager = create(:manager_profile, user: user)
    ticket_types = [
      build(:ticket_type, quantity: 4),
      build(:ticket_type, :paid)
    ]
    @event = create(:event,
                    ticket_types: ticket_types,
                    manager_profile: manager)

    booking = create(:booking, event: @event, user: user)
    i = 0
    2.times do
      create(:user_ticket,
             ticket_type: ticket_types[i],
             booking_id: booking.id
            )
      i += 1
    end

    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user)
  end

  scenario "Event manger clicks to view Tickets" do
    visit tickets_report_path(@event.id)
    expect(page.current_path).to eq tickets_report_path(@event.id)
    page_should_have_content(
      ["Tickets", "Grand Total", "SUMMARY", "ALL BOOKINGS", "ATTENDEES"]
    )

    within '#tickets_summary_table thead' do
      page_should_have_content(
        ["S/N", "Name", "Quantity", "Quantity Sold", "Ticket Left", "Price"]
      )
    end
  end
end
