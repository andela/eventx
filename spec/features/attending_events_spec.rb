require "rails_helper"
require "database_cleaner"

RSpec.feature "ViewEvents", type: :feature, js: true do
  before(:each) do
    set_valid_omniauth
    OmniAuth.config.test_mode = true
    FactoryGirl.create(:ticket_type)
    FactoryGirl.create(:manager_profile, user: FactoryGirl.create(:user))
    FactoryGirl.create(:event_with_ticket)
    FactoryGirl.create(:old_event)
    FactoryGirl.create(:sport_event)
  end
  after(:each) do
    DatabaseCleaner.clean
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
end
