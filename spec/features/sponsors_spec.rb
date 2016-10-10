require "rails_helper"

describe "Sponsors", type: :feature, js: true do
  before(:each) do
    @event = create(:regular_event)
    @event.event_staffs.create(role: 2, user: @event.manager_profile.user)
  end

  before(:each) do
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(@event.manager_profile.user)
  end

  scenario "creating a sponsor with valid details" do
    sponsor = build(:sponsor, event_id: @event.id)

    visit event_sponsors_path(@event)

    click_link "Add Sponsor"
    fill_in "sponsor_name", with: sponsor.name
    fill_in "sponsor_url", with: sponsor.url
    fill_in "sponsor_summary", with: sponsor.summary
    click_button "Save"

    expect(page).to have_content create_successful_message("sponsor")
  end

  scenario "updating a sponsor with valid details" do
    create(:sponsor, event_id: @event.id)
    sponsor = build(:sponsor, event_id: @event.id)

    visit event_sponsors_path(@event)

    find(".edit-sponsor-icon").trigger("click")
    fill_in "sponsor_name", with: sponsor.name
    fill_in "sponsor_url", with: sponsor.url
    fill_in "sponsor_summary", with: sponsor.summary
    click_button "Save"

    expect(page).to have_content update_successful_message("sponsor")
  end

  scenario "deleting a sponsor" do
    create(:sponsor, event_id: @event.id)
    visit event_sponsors_path(@event)

    find(".delete-sponsor-icon").trigger("click")
    page.evaluate_script("window.confirm = function() { return true; }")

    expect(page).to have_content delete_successful_message("sponsor")
  end
end
