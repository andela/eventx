require "rails_helper"
require "database_cleaner"

RSpec.feature "ViewEvents", type: :feature, js: true do
  before do
    FactoryGirl.create(:event_template)
    FactoryGirl.create(:category)
    FactoryGirl.create(:category2)
    FactoryGirl.create(:category3)
    FactoryGirl.create(:ticket_type)
    FactoryGirl.create(:ticket_type2)
    FactoryGirl.create(:user)
    FactoryGirl.create(:manager_profile)
    FactoryGirl.create(:event_with_ticket)
    FactoryGirl.create(:event_with_ticket1)
    FactoryGirl.create(:sport_event)
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
      expect(page).to have_selector("li.bold", count: Category.count+1)
    end
    click_link "All"
    expect(page).to have_content("Blessings wedding")
    expect(page).to have_content("Sports is cool")
    expect(page).to have_selector(".Amount", text: "FREE", count: 3)
    expect(page).to have_selector("Label", text: "Search Event")
    expect(page).to have_selector("Label", text: "Location")

    click_link "Music"
    expect(page).to have_content("Blessings wedding")

    click_link "Sports"
    expect(page).not_to have_content("Blessings wedding")
    expect(page).to have_content("Sports is cool")

    click_link "Parties"
    expect(page).not_to have_content("Blessings wedding")
    expect(page).not_to have_content("Sports is cool")
  end
end
