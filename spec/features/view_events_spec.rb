require "rails_helper"
require "database_cleaner"

RSpec.feature "ViewEvents", type: :feature, js: true do
  before do
    set_valid_omniauth
    OmniAuth.config.test_mode = true
    user = FactoryGirl.create(:user)
    manager = FactoryGirl.create(:manager_profile, user: user)
    event = FactoryGirl.create(:event_with_ticket, manager_profile: manager)
    FactoryGirl.create(:event_with_ticket, manager_profile: manager)
    FactoryGirl.create(:ticket_type_free, event: event)
    FactoryGirl.create(:ticket_type_free, event: event)
    FactoryGirl.create(:sport_event, manager_profile: manager)
  end
  after do
    DatabaseCleaner.clean
  end
  scenario "User tries to see all events" do
    visit events_path
    expect(page).to have_selector("h5", text: "Category")
    expect(page).to have_button("Search")
    within("#slide-out") do
      expect(page).to have_selector("li.bold", text: "All")
      expect(page).to have_selector("li.bold", count: Category.count + 1)
    end
    click_link "All"
    expect(page).to have_content("Blessings wedding")
    expect(page).to have_content("Sports is cool")
    expect(page).to have_selector(".Amount", text: "$9", count: 3)
    expect(page).to have_selector("Label", text: "Search Event")
    expect(page).to have_selector("Label", text: "Location")

    click_link "Music"
    expect(page).to have_content("Blessings wedding")

    click_link "Sport & Wellness"
    expect(page).not_to have_content("Blessings wedding")
    expect(page).to have_content("Sports is cool")

    click_link "Parties"
    expect(page).not_to have_content("Blessings wedding")
    expect(page).not_to have_content("Sports is cool")

    visit root_path
    click_link "UPCOMING"
    click_link "FEATURED"
    click_link "POPULAR"


  end
end
