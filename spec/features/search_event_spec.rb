require "rails_helper"

RSpec.feature "search_event:", type: :feature do
  before(:each) do
    create(:event)
    create(:next_week_event)
    create(:next_weekend_event)
    create(:this_weekend_event)
    create(:tomorrow_event)
  end

  scenario "User searches for today's events" do
    visit(root_path)
    click_button "Search"
    fill_in "event_name", with: "Blessings pre wedding"
    fill_in "event_location", with: "Beach side"
    select "Today", from: "event_date"
    click_button "Search"
    expect(page).not_to have_content "Blessings pre wedding"
  end

  scenario "User searches for tomorrow events" do
    visit(root_path)
    click_button "Search"
    fill_in "event_name", with: "Tomorrow Event"
    select "Tomorrow", from: "event_date"
    click_button "Search"
    expect(page).to have_content "Tomorrow Event"
  end

  scenario "User searches for this week events" do
    visit(root_path)
    click_button "Search"
    select "This week", from: "event_date"
    click_button "Search"
    expect(page).to have_content "Blessings wedding"
  end

  scenario "User searches for next week events" do
    visit(root_path)
    click_button "Search"
    select "Next week", from: "event_date"
    click_button "Search"
    expect(page).to have_content "Next week Event"
  end

  scenario "User searches for next weekend events" do
    visit(root_path)
    click_button "Search"
    fill_in "event_name", with: "Next weekend Event"
    fill_in "event_location", with: ""
    select "Next weekend", from: "event_date"
    click_button "Search"
    expect(page).to have_content "Next weekend Event"
  end
  scenario "User searches for this weekend events" do
    visit(root_path)
    click_button "Search"
    fill_in "event_name", with: "This weekend Event"
    fill_in "event_location", with: ""
    select "This weekend", from: "event_date"
    click_button "Search"
    expect(page).to have_content "This weekend Event"
  end

  scenario "User searches events happening now" do
    visit(root_path)
    click_button "Search"
    fill_in "event_name", with: "This weekend Event"
    click_button "Search"
    expect(page).to have_content "This weekend Event"
  end
end
