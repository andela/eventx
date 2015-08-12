require 'rails_helper'

RSpec.feature "ViewEvents", type: :feature do
  before(:all) do
    # Capybara.default_driver = :selenium
    page.driver.browser.manage.window.maximize()
  end

  before(:each) do
    category_1 = Category.create({name: 'Alex', description: "Alex's special category for crappy things"})
    category_2 = Category.create({name: 'KayOre',description: "Alex's special category for crappy things"})
  end
  scenario "User tries to see all events" do


    visit events_path


    # click_link 'SEE MORE'
    # save_and_open_page

    expect(page).to have_selector("h5", text: "Category")
    expect(page).to have_button("Search")

    within("#slide-out") do
      expect(page).to have_selector("li.bold", text: "All")
      expect(page).to have_selector("li.bold", count: Category.count+1)
    end
    expect(page).to have_field("")
  end
end
