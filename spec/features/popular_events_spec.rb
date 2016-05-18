require "rails_helper"

RSpec.feature "PopularEvents", type: :feature, js: true do
  before do
    sign_up_and_create_an_event_manager
  end

  scenario "User searches for popular Event" do
    visit events_popular_path
    expect(page).to have_content("Popular Events")
    expect(page.current_path).to eq "/events/popular"
  end
end
