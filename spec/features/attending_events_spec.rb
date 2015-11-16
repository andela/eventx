require "rails_helper"
require "database_cleaner"

RSpec.feature "ViewEvents", type: :feature, js: true do
  before do
    set_valid_omniauth
    OmniAuth.config.test_mode = true
    FactoryGirl.create(:event_template)
    FactoryGirl.create(:category)
    FactoryGirl.create(:category2)
    FactoryGirl.create(:category3)
    FactoryGirl.create(:ticket_type)
    FactoryGirl.create(:ticket_type2)
    FactoryGirl.create(:user)
    FactoryGirl.create(:manager_profile)
    FactoryGirl.create(:event_with_ticket)
    FactoryGirl.create(:old_event)
    FactoryGirl.create(:sport_event)
  end
  after do
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
