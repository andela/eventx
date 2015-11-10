require 'rails_helper'
require 'database_cleaner'

RSpec.feature "Event Manager abilities", type: :feature do
    before do
      OmniAuth.config.test_mode = true
      Category.create({name: 'Alex', description: "Alex's special category for crappy things"})
      Category.create({name: 'Music', description: "music's special category for crappy things"})
    end

    after do
      DatabaseCleaner.clean
    end

    scenario "user wants to become an Event Manager" do
      visit root_path

      click_link 'Log In'

      click_link 'Facebook'

      click_link 'Become An Event Manager'

      expect(page).to have_selector("p.center", text: "Create it, Preview it, Publish it!")
      expect(page).to have_field("event[title]", type: "text")
      expect(page).to have_field("event[venue]", type: "text")
      expect(page).to have_field("event[location]", type: "text")

      fill_in "event[title]", with: "This is a test Event"
      fill_in "event[location]", with: "Lagos, Nigeria"

      fill_in "event[venue]", with: "Amity"

      find('#event_category_id').find(:xpath, 'option[2]').select_option

      page.execute_script("$('#event_start_date').pickadate('picker').set('select', #{Date.tomorrow.to_time.to_i*1000})")
      page.execute_script("$('#event_end_date').pickadate('picker').set('select', #{Date.tomorrow.to_time.to_i*1000})")

      description = "This is a demo description for our event"
      fill_in "event[description]", with: description

      click_link "Next"

      click_link "Preview"

      expect(page).to have_selector('h3.our-event-title', text: "This is a test Event")
      expect(page).to have_selector('p.our_event_description', text: description)
      expect(page).to have_selector('label.our-event-date', text: "#{Date.tomorrow.strftime("%-d %B, %Y")} to #{Date.tomorrow.strftime("%-d %B, %Y")}")

      click_button "Save"

      expect(page).to have_selector('h3.our-event-title', text: "This is a test Event")
      expect(page).to have_selector('p.our_event_description', text: description)
      expect(page).to have_selector('label.our-event-date', text: "#{Date.tomorrow.strftime("%b %d %Y")} to #{Date.tomorrow.strftime("%b %d %Y")}")
    end

end
