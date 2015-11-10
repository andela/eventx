require 'rails_helper'
require 'database_cleaner'

RSpec.feature "ViewEvents", type: :feature, js: true do
  before :all do
    DatabaseCleaner.clean
  end
  after :all do
    DatabaseCleaner.clean
  end
  before(:each) do
    category_1 = Category.create({name: 'Alex', description: "Alex's special category for crappy things"})
    category_2 = Category.create({name: 'KayOre',description: "Alex's special category for crappy things"})
  end
  scenario "User tries to see all events" do
    visit events_path
    expect(page).to have_selector("h5", text: "Category")
    expect(page).to have_button("Search")
    within("#slide-out") do
      expect(page).to have_selector("li.bold", text: "All")
      expect(page).to have_selector("li.bold", count: Category.count+1)
    end
  end
end
