require "rails_helper"

RSpec.feature "ScanTicket", type: :feature, js: true do
  before(:each) do
    @user = create(:user, email: "user@eventx.com")
    @gate_keeper = create(:user, email: "gatekeeper@eventx.com")
    @event = create(:event)
    @event_staff = create(:event_staff, :gate_keeper, event: @event, user: @gate_keeper)
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(@gate_keeper)
  end

  scenario "User clicks to attend an event" do
    visit events_path
    click_link "Blessings wedding"
    click_link "Attend this event"
    within ".modal-content" do
      page.execute_script("$('#ticket_type_1').prop('checked', true)")
      fill_in "tickets_quantity_1", with: 1
      click_button "Submit"
    end
    visit gatekeeper_path(@event)
    fill_in "ticket_no", with: UserTicket.last.ticket_number
    click_button "search-button"
    expect(page).to have_content "Blessings wedding"
    expect(page).to have_content "VALID"
    find("#open-ticket-details").click
    expect(page).to have_content "Ticket Owner"
    find("#close-ticket-details").click
    click_link "Scan"
    expect(page).to have_content "USED"
    find("#open-ticket-details").click
    expect(page).to have_content "Scanned by"
  end
end
