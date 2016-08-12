require "rails_helper"

RSpec.feature "ViewEvents", type: :feature, js: true do
  before(:each) do
    manager =
      create(:manager_profile, user: create(:user))
    create(:event, manager_profile: manager)
    old = build(:old_event, manager_profile: manager)
    old.save(validate: false)
    create(:sport_event, manager_profile: manager)

    allow_any_instance_of(BookingsController).to receive(:trigger_booking_mail).
      and_return("")
  end

  scenario "User searches for an Event" do
    visit root_path
    fill_in "Search Event", with: "Sports is cool"
    click_button "Search"
    expect(page).not_to have_content("Blessings wedding")
    expect(page).to have_content("Sports is cool")
    expect(page.current_path).to eq "/events"
  end

  scenario "User tries to attend past Event" do
    visit events_path
    click_link "Old Event"
    expect(page).not_to have_content "ATTEND THIS EVENT"
    expect(page).to have_content "This event has ended"
  end

  scenario "User tries to attend Event" do
    visit events_path
    find_link("Blessings wedding").trigger("click")
    expect(page).to have_content "ATTEND THIS EVENT"
    expect(page).to have_content "Add to my Calendar"
    expect(page).to have_content "Add to Google Calendar"
  end

  scenario "User clicks to attend an event" do
    sign_up
    visit events_path
    click_link "Blessings wedding"
    find_link("Attend this event").trigger("click")
    within ".modal-content" do
      page.execute_script("$('#ticket_type_1').prop('checked', true)")
      fill_in "tickets_quantity_1", with: 1
      find_button("Submit").trigger("click")
    end

    expect(page).to have_content "DOWNLOAD ALL TICKETS"
    expect(page.current_path).to eq "/tickets"

    visit print_path(25)
    expect(page).to have_content "Booking not found"
    expect(page).to have_content "My Events"

    visit events_path
    click_link "Blessings wedding"
    expect(page).to have_content "UNATTEND"
    find_link("Unattend").trigger("click")

    visit events_path
    click_link "Blessings wedding"
    expect(page).to have_content "ATTEND THIS EVENT"
  end

  scenario "User does not specify ticket quantity" do
    sign_up
    visit events_path
    click_link "Blessings wedding"
    find_link("Attend this event").trigger("click")
    within ".modal-content" do
      fill_in "tickets_quantity_1", with: 0
      click_button "Submit"
      expect(page.current_path).to eq "/events/1"
    end
  end

  scenario "User specifies quantity above what is available" do
    sign_up
    visit events_path
    click_link "Blessings wedding"
    find_link("Attend this event").trigger("click")
    within ".modal-content" do
      fill_in "tickets_quantity_1", with: 1000
      click_button "Submit"
      expect(page.current_path).to eq "/events/1"
    end
  end
end
