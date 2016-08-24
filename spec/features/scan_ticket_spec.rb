require "rails_helper"

RSpec.feature "ScanTicket", type: :feature, js: true do
  before do
    @user = create(:user, email: "gatekeeper@eventx.com")
    @ticket_types = [build(:ticket_type)]
  end

  before(:each) do
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(@user)
  end

  scenario "User clicks to attend an event" do
    event = create(:event, ticket_types: @ticket_types)
    create(:event_staff, :gate_keeper, event: event, user: @user)
    booking = create(:booking, event: event, user: @user)
    create(:user_ticket, ticket_type: @ticket_types[0], booking_id: booking.id)

    visit gatekeeper_path(event)
    fill_in "ticket_no", with: "MyString"
    click_button "search-button"
    expect(page).to have_content "Blessings wedding"
    expect(page).to have_content "Valid"
    find("#open-ticket-details").click
    expect(page).to have_content "Ticket Owner"
    find("#close-ticket-details").click
    click_link "Scan"
    expect(page).to have_content "Used"
    find("#open-ticket-details").click
    expect(page).to have_content "Scanned by"
  end

  scenario "User clicks to attend an event" do
    event = create(:event, :cancelled, ticket_types: @ticket_types)
    booking = create(
      :booking,
      event: event,
      user: @user,
      payment_status: 2,
      amount: 20,
      refund_requested: true,
      granted: true
    )
    create(:event_staff, :gate_keeper, event: event, user: @user)
    create(:user_ticket, ticket_type: @ticket_types[0], booking_id: booking.id)
    visit gatekeeper_path(event)
    fill_in "ticket_no", with: booking.user_tickets.first.ticket_number
    click_button "search-button"
    expect(page).to have_content "Used"
    expect(page).not_to have_content "Scan"
  end
end
