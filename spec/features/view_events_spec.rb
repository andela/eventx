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

    @cat = create(:category, manager_profile: @manager)
  end

  scenario "User tries to see all events" do
    visit events_path

    expect(page).to have_button("Search")
    expect(page).to have_content("Blessings wedding")
    expect(page).to have_content("Sports is cool")
    expect(page).to have_selector(".Amount", text: "FREE", count: 3)
    expect(page).to have_selector(".Amount", text: "$9", count: 1)
    expect(page).to have_selector("Label", text: "Search Event")
    expect(page).to have_selector("Label", text: "Location")

    page.find("#music").trigger("click")
    expect(page).to have_content("Blessings wedding")

    page.find("#sport").trigger("click")
    expect(page).not_to have_content("Blessings wedding")
    expect(page).to have_content("Sports is cool")

    page.find("#parties").trigger("click")
    expect(page).not_to have_content("Blessings wedding")
    expect(page).not_to have_content("Sports is cool")
  end

  scenario "User tries to see all the events on a valid Manager subdomain" do
    allow_any_instance_of(ApplicationController).to receive(:modify).
      and_return(@manager.subdomain)

    visit events_path
    expect(page).to have_button("Search")
    page.find("#all").trigger("click")

    expect(page).to have_content(@cat.name)

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

    expect(page).not_to have_content(@cat.name)
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
