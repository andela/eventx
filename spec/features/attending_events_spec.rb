require "rails_helper"

RSpec.feature "ViewEvents", type: :feature, js: true do
  before(:each) do
    manager =
    FactoryGirl.create(:manager_profile, user: FactoryGirl.create(:user))
    FactoryGirl.create(:event, manager_profile: manager)
    old = FactoryGirl.build(:old_event, manager_profile: manager)
    old.save(validate: false)
    FactoryGirl.create(:sport_event, manager_profile: manager)

    allow_any_instance_of(BookingsController).to receive(:trigger_booking_mail).
      and_return("")
  end

  scenario "User wants to attend an Event" do
    visit root_path
    fill_in "Search Event", with: "Sports is cool"
    click_button "Search"
    expect(page).not_to have_content("Blessings wedding")
    expect(page).to have_content("Sports is cool")
    expect(page.current_path).to eq "/events"
    visit events_path
    click_link "Old Event"
    expect(page).not_to have_content "ATTEND THIS EVENT"
    expect(page).to have_content "This event has ended"
    visit events_path
    click_link "Blessings wedding"
    expect(page).to have_content "ATTEND THIS EVENT"
  end

  scenario "User clicks to attend an event" do
    sign_up

    visit events_path
    click_link "Blessings wedding"
    click_link "Attend this event"

    within ".modal-content" do
      page.execute_script("$('#ticket_type_1').prop('checked', true)")
      fill_in "tickets_quantity_1", with: 1
      click_button "Submit"
    end

    expect(page).to have_content "Blessings wedding"
    expect(page).to have_content "MyTicket"
    expect(page).to have_content "PRINT"
    expect(page).to have_content "DOWNLOAD"
    find("a[href='/print/1']").click

    visit tickets_path
    expect(page).to have_content "Blessings wedding"
    expect(page).to have_content "MyTicket"
    click_link("MyTicket")

    visit print_path(25)
    expect(page).to have_content "Booking not found"
    expect(page).to have_content "Blessings wedding"
    expect(page).to have_content "MyTicket"

    visit events_path
    click_link "Blessings wedding"
    expect(page).to have_content "UNATTEND"
    click_link "Unattend"

    visit events_path
    click_link "Blessings wedding"
    expect(page).to have_content "ATTEND THIS EVENT"
  end
end
