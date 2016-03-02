require "rails_helper"
require "database_cleaner"

RSpec.feature "ViewEvents", type: :feature, js: true do
  before do
    set_valid_omniauth
    OmniAuth.config.test_mode = true
    user = create(:user)
    manager = create(:manager_profile, user: user)
    create(:event, manager_profile: manager)
    create(:paid_event, manager_profile: manager)
    create(:sport_event, manager_profile: manager)

    user = create(:user)
    @manager = create(:manager_profile,
                      user: user,
                      subdomain: "sub",
                      company_mail: Faker::Internet.email)
    create(:event,
           manager_profile: @manager,
           title: "Subdomain event")
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
      click_link "All"
    end

    expect(page).to have_content("Blessings wedding")
    expect(page).to have_content("Sports is cool")
    expect(page).to have_selector(".Amount", text: "FREE", count: 3)
    expect(page).to have_selector(".Amount", text: "$9", count: 1)
    expect(page).to have_selector("Label", text: "Search Event")
    expect(page).to have_selector("Label", text: "Location")

    within("#slide-out") do
      click_link "Music"
    end
    expect(page).to have_content("Blessings wedding")

    within("#slide-out") do
      click_link "Sport & Wellness"
    end
    expect(page).not_to have_content("Blessings wedding")
    expect(page).to have_content("Sports is cool")

    within("#slide-out") do
      click_link "Parties"
    end
    expect(page).not_to have_content("Blessings wedding")
    expect(page).not_to have_content("Sports is cool")

    visit root_path
    click_link "UPCOMING"
    click_link "FEATURED"
    click_link "POPULAR"
  end

  scenario "User tries to see all the events on a valid Manager subdomain" do
    allow_any_instance_of(ApplicationController).to receive(:modify).
      and_return(@manager.subdomain)

    visit events_path
    expect(page).to have_selector("h5", text: "Category")
    expect(page).to have_button("Search")
    within("#slide-out") do
      expect(page).to have_selector("li.bold", text: "All")
      expect(page).to have_selector("li.bold", count: Category.count + 1)
      click_link "All"
    end

    expect(page).to have_content("Subdomain event")
    expect(page).not_to have_content("Blessings wedding")
    expect(page).not_to have_content("Sports is cool")
    expect(page).to have_selector(".Amount", text: "FREE", count: 1)
    expect(page).not_to have_selector(".Amount", text: "$9", count: 1)
    expect(page).to have_selector("Label", text: "Search Event")
    expect(page).to have_selector("Label", text: "Location")
  end

  scenario "User tries to see all the events on invalid Manager subdomain" do
    allow_any_instance_of(ApplicationController).to receive(:modify).
      and_return("invalid")

    visit events_path
    expect(page).not_to have_selector("h5", text: "Category")
    expect(page).not_to have_button("Search")

    expect(page).not_to have_content("Subdomain event")
    expect(page).not_to have_content("Blessings wedding")
    expect(page).not_to have_content("Sports is cool")
    expect(page).not_to have_selector(".Amount", text: "FREE", count: 1)
    expect(page).not_to have_selector(".Amount", text: "$9", count: 1)
    expect(page).not_to have_selector("Label", text: "Search Event")
    expect(page).not_to have_selector("Label", text: "Location")

    expect(page).to have_content("Sorry. We couldn't find that page :(")
    expect(page).to have_content("CONTINUE TO THE EVENT-X WEBSITE.")
  end
end
